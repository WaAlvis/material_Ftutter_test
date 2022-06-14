import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_history_operation/detail_history_operation_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:provider/provider.dart';

import 'detail_history_operation_status.dart';

class DetailHistoryOperationViewModel extends EffectsViewModel<
    DetailHistoryOperationStatus, DetailHistoryOperationEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;
  final String idUser;

  DetailHistoryOperationViewModel(
    this._route,
    this._interactor,
    this.idUser,
  ) {
    status = DetailHistoryOperationStatus(
      isLoading: true,
      isError: false,
    );
  }

  Future<void> onInit(BuildContext context) async {
    getName(
      idUser,
      context,
    );
  }

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  String dateOperation(
    int timeStamp,
  ) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    final DateFormat day = DateFormat.MMMMd('ES_CO');
    final DateFormat hour = DateFormat.jm('ES_CO');
    final DateFormat year = DateFormat.y('ES_CO');
    final String monthDayF = day.format(date);
    final String hourF = hour.format(date);
    final String yearF = year.format(date);
    return '$monthDayF del $yearF a las $hourF';
  }

  String formatNumberPoint(String value) {
    return NumberFormat.simpleCurrency(
      decimalDigits: 0,
      name: '',
      locale: 'IT',
    ).format(
      double.parse(value),
    );
  }

  String calculateCopTotal({
    required String margin,
    required String valueToSell,
  }) {
    final double value = double.parse(margin) * double.parse(valueToSell);
    return formatNumberPoint(value.toString());
  }

  void goProfileSeller(
    BuildContext context, {
    required String idUserPublish,
    required String nickName,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goProfileSeller(context, idUserPublish, nickName);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void getName(String idBuyer, BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        getNameBuyer(idBuyer, context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> getNameBuyer(String idBuyer, BuildContext context) async {
    status = status.copyWith(isLoading: true);
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    final token = dataUserProvider.getTokenLogin;
    _interactor
        .getUserById(idUser, 'Bearer ${token!.token}')
        .then((ResponseData<ResultDataUser> response) {
      if (response.isSuccess) {
        final ResultDataUser? userBuyer = response.result;
        status = status.copyWith(userBuyer: userBuyer);
      } else {
        addEffect(ShowErrorSnackbar('Error al obtener el nombre'));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      addEffect(ShowErrorSnackbar('Error en el Servicio **'));
      status = status.copyWith(isLoading: false);
    });
  }
}
