import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/view_model.dart';
import 'package:intl/intl.dart';

import 'dart:math';

import 'history_status.dart';

class HistoryViewModel extends ViewModel<HistoryStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;
  final List<DataUserAdvertisement>? operations;

  HistoryViewModel(
    this._route,
    this._interactor,
    this.operations,
  ) {
    status = HistoryStatus(
      isLoading: true,
      isError: false,
      allLoaded: false,
      daysMockHistory: <DayOperation>[],
      operations: operations ?? [],
      operationsForDay: [],
    );
  }

  Future<void> onInit(ScrollController scrollCtrl) async {
    // mockFetch();
    organizeDaysOperations(status.operations);
    // if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent &&
    //     !status.isLoadingHistory) {
    //   print('Get Data Historial');
    //   mockFetch();
    // }
    // scrollCtrl.addListener(() {
    //   if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent &&
    //       !status.isLoadingHistory) {
    //     print('Get Data Historial');
    //     mockFetch();
    //   }
    // });
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
        .fold(<String, List<DataUserAdvertisement>>{},
            (Map<String, List<DataUserAdvertisement>> a, DataUserAdvertisement b) {
          final int creationDate = b.advertisement.creationDate;
          final String parseDate = formatDate(creationDate, 'yyyy-MM-dd');
          a.putIfAbsent(parseDate, () => <DataUserAdvertisement> []).add(b);
          return a;
        })
        .values
        .where((List<DataUserAdvertisement> l) => l.isNotEmpty)
        .map((List<DataUserAdvertisement> l) =>
    GroupAdvertisement(wrapedDate:
                formatDate(l.first.advertisement.creationDate,'MMMM dd yyyy'),data: l ,),
    )
        .toList();

    status = status.copyWith(operationsForDay: value);

  }

  void goDetailHistoryOperation(BuildContext context,
      {required Operation item}) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goDetailHistoryOperation(context, item);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
