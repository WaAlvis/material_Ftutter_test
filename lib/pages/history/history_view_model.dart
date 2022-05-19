import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/history/history_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/history_operations_user/body_history_operations_user.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/services/models/history_operations_user/response/result_history_operations_user.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'history_status.dart';

class HistoryViewModel extends EffectsViewModel<HistoryStatus, HistoryEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  HistoryViewModel(
    this._route,
    this._interactor,
  ) {
    status = HistoryStatus(
      isLoading: true,
      isError: false,
      // allLoaded: false,
      listHistoryOperations: <DataUserAdvertisement>[],
      operationsForDay: <GroupAdvertisement>[],
    );
  }

  Future<void> onInit(
    String idUser, {
    bool refresh = false,
  }) async {
    getOperations(idUser);
  }

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  List<GroupAdvertisement> organizeDaysOperations(
    List<DataUserAdvertisement> data,
  ) {
    String formatDate(int timeStamp, String format) {
      final DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      final DateFormat formatter = DateFormat(format, 'ES_CO');
      return formatter.format(date);
    }

    final List<GroupAdvertisement> value = data
        .fold(<String, List<DataUserAdvertisement>>{}, (
          Map<String, List<DataUserAdvertisement>> a,
          DataUserAdvertisement b,
        ) {
          final int creationDate = b.advertisement.creationDate;
          final String parseDate = formatDate(creationDate, 'yyyy-MM-dd');
          a.putIfAbsent(parseDate, () => <DataUserAdvertisement>[]).add(b);
          return a;
        })
        .values
        .where((List<DataUserAdvertisement> l) => l.isNotEmpty)
        .map(
          (List<DataUserAdvertisement> l) => GroupAdvertisement(
            wrapedDate:
                formatDate(l.first.advertisement.creationDate, 'MMMM dd yyyy'),
            data: l,
          ),
        )
        .toList();
    return value;
  }

  void getOperations(String idUser) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        getAndOrderOperationsForDay(idUser);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> getAndOrderOperationsForDay(String idUSer) async {
    status = status.copyWith(isLoading: true);

    final BodyHistoryOperationsUser bodyHistoryOperationsUser =
        BodyHistoryOperationsUser(
      idUser: idUSer,
      pagination: Pagination(
        isPaginable: true,
        currentPage: 1,
        itemsPerPage: 10,
      ),
    );

    _interactor
        .getHistoryOperationsUser(bodyHistoryOperationsUser)
        .then((ResponseData<ResultHistoryOperationsUser> response) async {
      if (response.isSuccess) {
        final List<DataUserAdvertisement> dataOperations =
            response.result!.data;
        if (dataOperations.isNotEmpty) {
          final List<GroupAdvertisement> value =
              organizeDaysOperations(dataOperations);
          status = status.copyWith(
            operationsForDay: value,
          );
        } else {
          status = status.copyWith(isDataEmpty: true);
        }
      } else {
        addEffect(ShowErrorSnackbar('Error en la consulta'));

      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      addEffect(ShowErrorSnackbar('**Error en el Servicio'));
      status = status.copyWith(isLoading: false);
    });
  }

  void goDetailHistoryOperation(
    BuildContext context, {
    required DataUserAdvertisement item,
    required bool isBuying,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goDetailHistoryOperation(
          context, item,
          isBuying: isBuying,
        );
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  String calculateDlyTotal(List<DataUserAdvertisement> data, int index) {
    final double value = double.parse(data[index].advertisement.valueToSell);

    final String totalDlycop = formatNumberPoint(value.toString());
    return totalDlycop;
  }

  String calculateCopTotal(List<DataUserAdvertisement> data, int index) {
    final double value = double.parse(
          data[index].advertisement.margin,
        ) *
        double.parse(
          data[index].advertisement.valueToSell,
        );
    final String totalCop = formatNumberPoint(value.toString());
    return totalCop;
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
}
