import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
// import 'package:localdaily/services/models/login/body_login.dart';
// import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'offert_sale_status.dart';

class OffertSaleViewModel extends ViewModel<OffertSaleStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  OffertSaleViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = OffertSaleStatus(
      isLoading: false,
      isError: true,
    );
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goRegister(BuildContext context) {
    _route.goEmailRegister(context);
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goEmailRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goRecoverPassword(BuildContext context) {
    print('Implementar vista de recuperar contrasenia');
    // _route.goEmailRegister(context);
    // LdConnection.validateConnection().then((bool value) {
    //   if (value) {
    //     _route.goEmailRegister(context);
    //   } else {
    //     // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
    //   }
    // });
  }



}
