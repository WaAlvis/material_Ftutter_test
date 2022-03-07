import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:string_validator/string_validator.dart';

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
      // isError: true,
      hidePass: true,
      errorLogin: false,
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
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goRegister(BuildContext context) {
    _route.goEmailRegister(context);
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goEmailRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goRecoverPassword(BuildContext context) {
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

  void closeErrMsg() {
    status = status.copyWith(errorLogin: false);
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
    DataUserProvider dataUserProvider,
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
          status = status.copyWith(
            errorLogin: true,
          );
          print('Login DataFull Error As: ${err}');
          status = status.copyWith(isLoading: false);
        });
      } else {
        status = status.copyWith(
          errorLogin: true,
        );
        // TODO: Mostrar alerta

      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      status = status.copyWith(
        errorLogin: true,
      );
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
