import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
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

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(
    BuildContext context,
    TextEditingController userCtrl,
    TextEditingController passwordCtrl,
  ) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        login(context, userCtrl.text, passwordCtrl.text);
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
      BuildContext context, String email, String password) async {
    status = status.copyWith(isLoading: true);
    String pass256 = encrypPass(password).toString();
    print('Email: $email');
    print('Password: $password');
    print('Pass256: $pass256');


    final BodyLogin bodyLogin = BodyLogin(
      identity: email,
      password: pass256,
      signature:
      'abKOWolU4vV/9URccer1B2V6WogwH2shwyN9k8x5BYqfrf76guQZqkfozlxXaEDrxUORoE/aL82mhvYPWBf4CqtKOLeO4nza/CuR0s7M3qYa1WlubBikJVmaY+GO3WWPxfnX2EZ8VT9cktKjTX+yQS8D0iHFrUfu8NQZjdCBmeHPoWBb5esYovvqseSZcnX4K0vBUlYvRvqBcvw0UF2NcB2wjR7wmohTdWeY+l99MT3JpVradzMPjGEpTRII1Sf7N41FiKawGStWmuBL5zzIVD+JjDzN7PlGeGPUuoXJ2zlX+swp26/LKkPfrqK21UemZmxPE7oYkb+gb9SDbYJpsQ==',
      wearableId: 'd9b1289a-ae98-4e86-a145-ac046a8bd5be',
    );

    try {
      final ResponseData<ResultLogin> response =
          await _interactor.postLogin(bodyLogin);
      print('Login Res: ${response.statusCode} ');
      if (response.isSuccess) {
        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Login Error As: ${err}');
    }
    status = status.copyWith(isLoading: false);
  }

  Digest encrypPass(String pass) {
    var bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }
}
