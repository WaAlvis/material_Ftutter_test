import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/view_model.dart';
import 'dart:math';

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
      isLoadingHistory: false,
      allLoaded: false,
      daysMockHistory: <DayOperation>[],
    );
  }

  Future<void> onInit(ScrollController scrollCtrl) async {
    mockFetch();
    // if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent &&
    //     !status.isLoadingHistory) {
    //   print('Get Data Historial');
    //   mockFetch();
    // }
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent &&
          !status.isLoadingHistory) {
        print('Get Data Historial');
        mockFetch();
      }
    });
  }

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  Future<void> mockFetch() async {
    final int dayRandom = Random().nextInt(28);
    final int amountOpr = Random().nextInt(5);

    if (status.allLoaded) {
      return;
    }
    status = status.copyWith(isLoadingOperations: true);
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );
    // List<String> newData =
    // items.length >= 10 ? [] : List.generate(1, (index) => 'null');

    final List<DayOperation> newData = status.daysMockHistory.length >= 60
        ? <DayOperation>[]
        : List.generate(
            //mockFetchData
            5, (int index) {
            return DayOperation(
              <Operation>[
                Operation('${(Random().nextInt(10) + 1).toString()}.000.000',
                    '1.2', 'NickUser$index', '4.5'),
                Operation('-${(Random().nextInt(4) + 1).toString()}.500.000',
                    '1.5', 'NickUser$index', '4.5'),
                Operation('${(Random().nextInt(5) + 1).toString()}.200.000',
                    '0.8', 'NickUser$index', '4.5'),
              ],
              date: 'Noviembre $dayRandom de 2021',
            );
          });
    if (newData.isNotEmpty) {
      status.daysMockHistory.addAll(newData);
    }
    status =
        status.copyWith(isLoadingOperations: false, allLoaded: newData.isEmpty);
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
