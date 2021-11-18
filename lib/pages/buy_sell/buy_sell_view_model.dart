import 'package:flutter/cupertino.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/view_model.dart';
import 'buy_sell_status.dart';

class BuySellViewModel extends ViewModel<BuySellStatus> {

  final LdRouter _route;
  final ServiceInteractor _interactor;

  BuySellViewModel(this._route, this._interactor) {
    status = BuySellStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goHome(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
