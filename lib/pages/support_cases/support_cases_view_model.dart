import 'package:flutter/material.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/support_cases/support_cases_effect.dart';
import 'package:localdaily/pages/support_cases/support_cases_status.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/support_cases/body_support_cases.dart';
import 'package:localdaily/services/models/support_cases/result_support_cases.dart';
import 'package:localdaily/view_model.dart';

class SupportCasesViewModel
    extends EffectsViewModel<SupportCasesStatus, SupportCasesEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  final int itemsPerPage = 10;

  SupportCasesViewModel(this._route, this._interactor) {
    status = SupportCasesStatus(
      isLoading: false,
      isError: false,
      resultSupportCases: ResultSupportCases(
        data: <BodyContactSupport>[],
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
      addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
    }
  }

  Future<bool?> getData(
    String userId, {
    bool refresh = false,
    bool isPagination = false,
  }) async {
    if (!refresh &&
        status.resultSupportCases.data.isNotEmpty &&
        !isPagination) {
      return false;
    }

    if (isPagination &&
        status.resultSupportCases.data.length >=
            status.resultSupportCases.totalItems) {
      return false;
    }

    status = status.copyWith(isLoading: !isPagination);

    int currentPage = 1;
    // Calculo de la pagina actual para realizar paginación a la siguiente página
    if (status.resultSupportCases.data.length >= itemsPerPage) {
      currentPage = (status.resultSupportCases.data.length ~/ itemsPerPage) + 1;
    }
    final BodyContactSupport filters = BodyContactSupport(
      idUserPublish: userId,
      description: '',
      idSupportType: '',
      idAdvertisement: '',
      emailUserPublish: '',
      datePublish: '',
      dateSolution: '',
      id: '',
      idSupportStatus: '',
      idUserSupport: '',
      jiraKey: '',
      jiraLink: '',
      userPublishNickname: '',
    );
    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: currentPage,
      itemsPerPage: itemsPerPage,
    );
    final BodySupportCases body =
        BodySupportCases(filters: filters, pagination: pagination);

    try {
      await _interactor.getSupportCases(body).then((response) {
        status = status.copyWith(isLoading: false);
        if (response.isSuccess) {
          final List<BodyContactSupport> data = <BodyContactSupport>[
            ...status.resultSupportCases.data,
            ...response.result!.data
          ];
          status = status.copyWith(
            resultSupportCases: isPagination
                ? ResultSupportCases(
                    data: data,
                    totalItems: status.resultSupportCases.totalItems,
                    totalPages: status.resultSupportCases.totalPages,
                  )
                : response.result!,
          );
        }
      });
    } catch (e) {
      status = status.copyWith(isLoading: false);
      addEffect(
        ShowSnackbarErrorEffect(
          'No se pudo procesar la solicitud, intenta más tarde',
        ),
      );
      print('Error support cases $e');
    }
  }

  void goDetailSupport(BuildContext context, BodyContactSupport advertisement) {
    _route.goDetailSupport(context, advertisement);
  }
}
