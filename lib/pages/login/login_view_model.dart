import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/providers/user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'login_status.dart';

class LoginViewModel extends ViewModel<LoginStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  LoginViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = LoginStatus(
      isLoading: false,
      isError: true,
    );
  }

  Future<void> onInit({
    bool validateNotification = false,
  }) async {}

  void goHome(
    BuildContext context,
    TextEditingController userCtrl,
    TextEditingController passwordCtrl,
    UserProvider userProvider,
  ) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        login(
          context,
          userCtrl.text,
          passwordCtrl.text,
          userProvider,
        );
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

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

  Future<void> login(
    BuildContext context,
    String email,
    String password,
    UserProvider userProvider,
  ) async {
    status = status.copyWith(isLoading: true);
    final String pass256 = encrypPass(password).toString();
    print('Email: $email');
    print('Password: $password');
    print('Pass256: $pass256');

    final BodyLogin bodyLogin = BodyLogin(
      identity: email,
      password: password,
      signature:
          'T2CswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==',
      wearableId: 'd9b1289a-ae98-4e86-a145-ac046a8bd5be',
    );

    _interactor.postLogin(bodyLogin).then((ResponseData<ResultLogin> response) {
      print('Login Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Login EXITOSO!!');
        userProvider.setUserLogged(
          response.result!.user,
        );
        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      print('Login Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
  }

  Digest encrypPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }
}
