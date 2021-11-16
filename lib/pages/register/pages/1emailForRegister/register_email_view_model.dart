import 'package:flutter/cupertino.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/view_model.dart';
import 'register_email_status.dart';

class RegisterViewModel extends ViewModel<RegisterStatus> {

  final LdRouter _route;
  final ServiceInteractor _interactor;

  RegisterViewModel(this._route, this._interactor) {
    status = RegisterStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goPersonalInfoRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goValidateEmail(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goValidateEmail(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
