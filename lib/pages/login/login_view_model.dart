import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/login/login_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:string_validator/string_validator.dart';

import 'login_status.dart';

class LoginViewModel extends EffectsViewModel<LoginStatus, LoginEffect> {
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
      isError: false,
      hidePass: true,
      isEmailFieldEmpty: true,
      isPswFieldEmpty: true,
    );
  }

  void hidePassword() => status = status.copyWith(
        hidePass: !status.hidePass,
      );

  Future<void> onInit({
    bool validateNotification = false,
  }) async {}

  //Login
  void changeEmail(String email) =>
      status = status.copyWith(isEmailFieldEmpty: email.isEmpty);

  void changePsw(String psw) =>
      status = status.copyWith(isPswFieldEmpty: psw.isEmpty);

  //Register

  void goHomeForLogin(
    BuildContext context,
    GlobalKey<FormState> keyForm,
    TextEditingController userCtrl,
    TextEditingController passwordCtrl,
    DataUserProvider dataUserProvider,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        if (keyForm.currentState!.validate()) {
          login(
            context,
            userCtrl.text,
            passwordCtrl.text,
            dataUserProvider,
          );
        }
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goRegister(BuildContext context) {
    _route.goEmailRegister(context);
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goEmailRegister(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goRecoverPassword(BuildContext context) {
    print('Implementar vista de recuperar contrasenia');
    _route.goRecoverPsw(context);
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        // _route.goEmailRegister(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
    DataUserProvider dataUserProvider,
  ) async {
    status = status.copyWith(isLoading: true);
    final String pass256 = encrypPass(password).toString();

    final BodyLogin bodyLogin = BodyLogin(
      identity: email,
      password: pass256,
      signature:
          'T2CswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==',
      wearableId: 'd9b1289a-ae98-4e86-a145-ac046a8bd5be',
    );

    _interactor.postLogin(bodyLogin).then((ResponseData<ResultLogin> response) {
      print('Login Res: ${response.statusCode} ');
      if (response.isSuccess) {
        final String idUser = response.result!.user.id;
        _interactor
            .getUserById(idUser)
            .then((ResponseData<ResultDataUser> response) {
          if (response.isSuccess) {
            print('Login EXITOSO + Datos user completps!!');
            dataUserProvider.setDataUserLogged(
              response.result,
            );
            _route.goHome(context);
          }
        }).catchError((err) {
          // addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));

          print('Login DataFull Error As: ${err}');
          status = status.copyWith(isLoading: false);
        });
      } else {
        String err = '';
        if (response.error!.message == 'The credential  not match.') {
          err = 'La contraseña es incorrecta.';
        } else {
          err = 'El correo no esta registrado.';
        }
        addEffect(ShowSnackbarErrorCredential(err));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      print('Login BasicData Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
  }

  Digest encrypPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
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

  String? validatorPass(String? pass) {
    {
      if (pass == null || pass.isEmpty) {
        return '* Campo necesario';
      } else if (pass.length < 8) {
        return '* Contraseña incompleta';
      }
      return null;
    }
  }
}
