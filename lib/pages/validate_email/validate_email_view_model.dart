import 'package:flutter/cupertino.dart';
import 'package:localdaily/api/repository/interactor/api_interactor.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/view_model.dart';
import 'validate_email_status.dart';

class ValidateEmailViewModel extends ViewModel<ValidateEmailStatus> {

  final LdRouter _route;
  final ApiInteractor _interactor;

  ValidateEmailViewModel(this._route, this._interactor) {
    status = ValidateEmailStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(BuildContext context) {
    LdConnection().validateConnection().then((bool value) {
      if (value) {
        _route.goHome(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
