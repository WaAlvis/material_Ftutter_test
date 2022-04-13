import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';
import 'package:string_validator/string_validator.dart';

import 'recover_psw_status.dart';

class RecoverPswViewModel extends ViewModel<RecoverPswStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  RecoverPswViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = RecoverPswStatus(
      isLoading: false,
      isError: false,
    );
  }

  Future<void> onInit({
    bool validateNotification = false,
  }) async {}



  void getRecoverPsw(BuildContext context) {
    print('Implementar vista de recuperar contrasenia');
    // _route.goEmailRegister(context);
    // LdConnection.validateConnection().then((bool isConnectionValidvalue) {
    //   if (value) {
    //     _route.goEmailRegister(context);
    //   } else {
    //     // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
    //   }
    // });
  }

  String? validatorEmail(String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo necesario';
      } else if (!isEmail(email)) {
        return '* Debe ser un correo';
      }
      return null;
    }
  }
}
