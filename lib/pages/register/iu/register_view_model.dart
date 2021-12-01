import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'register_status.dart';

class RegisterViewModel extends ViewModel<RegisterStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  List<int> bytes = utf8.encode('woolha');

  RegisterViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = RegisterStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  // void goHome(BuildContext context) {
  //   LdConnection.validateConnection().then((bool value) {
  //     if (value) {
  //       _route.goHome(context);
  //     } else {
  //       // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
  //     }
  //   });
  // }

  void goValidateEmail(BuildContext context, String email) {
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

  Future<void> registerUser(
    BuildContext context, {
    required TextEditingController nickNameCtrl,
    required TextEditingController firstNameCtrl,
    required TextEditingController firstLastNameCtrl,
    required TextEditingController secondNameCtrl,
    required TextEditingController secondLastNameCtrl,
    required TextEditingController phoneCtrl,
    required TextEditingController emailCtrl,
    required TextEditingController dateBirthCtrl,
    required TextEditingController passwordCtrl,
    required TextEditingController confirrmPassCtrl,
    // String email, String password,
  }) async {
    status = status.copyWith(isLoading: true);
    LdConnection.validateConnection().then(
      (bool value) {
        if (value) {
          register(
            context,
            nickName: nickNameCtrl.text,
            firstName: firstNameCtrl.text,
            firstLastName: firstLastNameCtrl.text,
            secondName: secondNameCtrl.text,
            secondLastName: secondLastNameCtrl.text,
            password: passwordCtrl.text,
            phone: phoneCtrl.text,
            email: emailCtrl.text,
            dateBirth: dateBirthCtrl.text,
          );
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    );
  }

  Future<void> register(
    BuildContext context, {
    required String nickName,
    required String firstName,
    required String firstLastName,
    required String secondName,
    required String secondLastName,
    required String password,
    required String phone,
    required String email,
    required String dateBirth,
  }) async {

    status = status.copyWith(isLoading: true);
    print('name: $firstName');
    print('Email: $email');
    final String sha256pass = encrypPass(password).toString();
    print('pass256 $sha256pass');

    final BodyRegisterDataUser bodyRegister = BodyRegisterDataUser(
      nickName: nickName,
      firstName: firstName,
      secondName: secondName,
      firstLastName: firstLastName,
      secondLastName: secondLastName,
      dateBirth: '1985/10/25',
      email: email,
      phone: phone,
      userTypeId: '9c2f4526-5933-4404-96fc-784a87a7b674',
      password: sha256pass,
      isActive: true,
    );

      _interactor.postRegisterUser(bodyRegister).then((ResponseData<ResultRegister> response) {
        print('Register Res: ${response.statusCode} ');
        if (response.isSuccess) {
          _route.goHome(context);
        } else {
          // TODO: Mostrar alerta
        }
        status = status.copyWith(isLoading: false);
      }).catchError((Object err) {
        print('Registro Error As: $err');
        status = status.copyWith(isLoading: false);
      });
  }

  Digest encrypPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }
}
