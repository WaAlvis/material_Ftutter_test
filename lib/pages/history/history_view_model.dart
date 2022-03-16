import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'history_status.dart';

class HistoryViewModel extends ViewModel<HistoryStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  HistoryViewModel(this._route, this._interactor) {
    status = HistoryStatus(isLoading: true, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goBack(BuildContext context) {
    _route.pop(context);
  }

// void goHome(BuildContext context) {
//   LdConnection.validateConnection().then((bool isConnectionValidvalue) {
//     if (isConnectionValidvalue) {
//       _route.goHome(context);
//     } else {
//       // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
//     }
//   });
// }
}
