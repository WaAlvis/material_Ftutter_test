import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/history_operations_user/body_history_operations_user.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/services/models/history_operations_user/response/result_history_operations_user.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'history_status.dart';

class HistoryViewModel extends ViewModel<HistoryStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  HistoryViewModel(
    this._route,
    this._interactor,
  ) {
    status = HistoryStatus(
      isLoading: true,
      isError: false,
      allLoaded: false,
      listHistoryOperations: <DataUserAdvertisement>[],
      operationsForDay: <GroupAdvertisement>[],
    );
  }

  Future<void> onInit(
    String idUser, {
    bool refresh = false,
  }) async {
    await getAndOrderOperationsForDay(idUser);
  }

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  void organizeDaysOperations(List<DataUserAdvertisement> data) {
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

    status = status.copyWith(operationsForDay: value);
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
        .then((ResponseData<ResultHistoryOperationsUser> response) {
      if (response.isSuccess) {
        final List<DataUserAdvertisement> dataOperations =
            response.result!.data;
        organizeDaysOperations(dataOperations);
      } else {
        //Add effect NOT success
      }
    }).catchError((Object err) {
      print('Operations User Error As: $err');
      status = status.copyWith(isLoading: false);
    });
    status = status.copyWith(isLoading: false);
  }

  void goDetailHistoryOperation(
    BuildContext context, {
    required Operation item,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goDetailHistoryOperation(context, item);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
