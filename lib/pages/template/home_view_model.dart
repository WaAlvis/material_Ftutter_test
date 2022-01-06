import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'home_status.dart';

class HomeViewModel extends ViewModel<HomeStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  HomeViewModel(this._route, this._interactor) {
    status = HomeStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goHome(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
