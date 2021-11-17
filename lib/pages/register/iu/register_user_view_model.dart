import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'register_user_status.dart';

class RegisterUserViewModel extends ViewModel<RegisterUserStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  RegisterUserViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = RegisterUserStatus(isLoading: false, isError: false);
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

  void goValidateEmail(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goValidateEmail(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goRegisterPersonalData(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goPersonalInfoRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
