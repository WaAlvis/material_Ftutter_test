import 'package:flutter/material.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/notification/notification_effect.dart';
import 'package:localdaily/pages/notification/notification_status.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/notifications/body_notifications.dart';
import 'package:localdaily/services/models/notifications/notification.dart';
import 'package:localdaily/services/models/notifications/result_notification.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/view_model.dart';

class NotificationViewModel
    extends EffectsViewModel<NotificationStatus, NotificationEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  final int itemsPerPage = 10;

  NotificationViewModel(this._route, this._interactor) {
    status = NotificationStatus(
      isLoading: false,
      isError: false,
      resultNotification: ResultNotification(
        data: <NotificationP>[],
        totalItems: itemsPerPage,
        totalPages: 1,
      ),
    );
  }

  Future<void> onInit(String userId) async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      await getData(userId);
    } else {
      addEffect(SnackbarConnectivityEffect('Sin conexión a internet'));
    }
  }

  void removeNotification(String id) {
    final List<NotificationP> notification = status.resultNotification.data
        .where((element) => element.id != id)
        .toList();

    status = status.copyWith(
      resultNotification: ResultNotification(
        data: notification,
        totalItems: notification.length < status.resultNotification.data.length
            ? status.resultNotification.totalItems - 1
            : status.resultNotification.totalItems,
        totalPages: status.resultNotification.totalPages,
      ),
    );

    // TODO: Conectar servicio para eliminar notificación
  }

  Future<bool> goHome(BuildContext context) async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      _route.goHome(context);
      return false;
    } else {
      addEffect(SnackbarConnectivityEffect('Sin conexión a internet'));
      return false;
    }
  }

  Future<bool?> getData(
    String userId, {
    bool refresh = false,
    bool isPagination = false,
  }) async {
    if (!refresh &&
        status.resultNotification.data.isNotEmpty &&
        !isPagination) {
      return false;
    }

    if (isPagination &&
        status.resultNotification.data.length >=
            status.resultNotification.totalItems) {
      return false;
    }

    status = status.copyWith(isLoading: !isPagination);

    int currentPage = 1;
    // Calculo de la pagina actual para realizar paginación a la siguiente página
    if (status.resultNotification.data.length >= itemsPerPage) {
      currentPage = (status.resultNotification.data.length ~/ itemsPerPage) + 1;
    }

    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: currentPage,
      itemsPerPage: itemsPerPage,
    );
    final BodyNotifications body =
        BodyNotifications(idUser: userId, pagination: pagination);

    try {
      await _interactor.getNotifications(body).then((response) {
        status = status.copyWith(isLoading: false);
        if (response.isSuccess) {
          final List<NotificationP> data = <NotificationP>[
            ...status.resultNotification.data,
            ...response.result!.data
          ];
          status = status.copyWith(
            resultNotification: isPagination
                ? ResultNotification(
                    data: data,
                    totalItems: status.resultNotification.totalItems,
                    totalPages: status.resultNotification.totalPages,
                  )
                : response.result!,
          );
        }
      });
    } catch (e) {
      status = status.copyWith(isLoading: false);
      addEffect(
        SnackbarErrorEffect(
          'No se pudo procesar la solicitud, intenta más tarde',
        ),
      );
      print('Error notificaciones $e');
    }
  }
}
