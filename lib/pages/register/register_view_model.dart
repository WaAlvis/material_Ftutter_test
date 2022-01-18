import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/register/send_validate/body_pin_email.dart';
import 'package:localdaily/services/models/register/send_validate/entity_pin_email.dart';
import 'package:localdaily/services/models/register/send_validate/result_pin_email.dart';
import 'package:localdaily/services/models/register/validate_pin/body_validate_pin.dart';
import 'package:localdaily/services/models/register/validate_pin/entity_validate_pin.dart';
import 'package:localdaily/services/models/register/validate_pin/result_validate_pin.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:string_validator/string_validator.dart';

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

    status = RegisterStatus(
      indexStep: 1,
      isLoading: false,
      isError: false,
      emailRegister: '',
      dateBirthCtrl: TextEditingController(),
      isEmailFieldEmpty: true,
      isPossibleOpenEmail: true,
      isNickNameFieldEmpty: true,
      isFirstNameFieldEmpty: true,
      isFirstLastNameFieldEmpty: true,
      isSecondNameFieldEmpty: true,
      isSecondLastNameFieldEmpty: true,
      isPhoneFieldEmpty: true,
      isDateBirthFieldEmpty: true,
      isPasswordFieldEmpty: true,
      isConfirmPassFieldEmpty: true,
      hidePass: true,
      acceptTermCoditions: false,
      hasUpperLetter: false,
      hasMore8Chars: false,
      hasSpecialChar: false,
      hasLowerLetter: false,
      hasNumberChar: false,
    );
  }

  String? validatorNotEmpty(String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo necesario';
      }
      return null;
    }
  }

  String? validatorPasswords(String? psw, String? confirmPsw) {
    if (psw == null || psw.isEmpty) {
      return '* la contraseña es necesaria';
    } else if (psw != confirmPsw) {
      return 'Las contraseñas no coinciden';
    }
    if (psw.length < 8 || confirmPsw!.length < 8) {
      return 'La contraseña debe incluir al menos 8 caracteres alfanuméricos';
    }
    if (!isPasswordValid(psw)) {
      return 'La contraseña no cumple los requerimientos';
    }
    return null;
  }

  String? validatorEmail(BuildContext context, String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo necesario';
      } else if (!isEmail(email)) {
        return '* Debe ser un correo';
      }
      return null;
    }
  }

  String? validatorCheckBox({bool? valueCheck}) {
    if (valueCheck!) {
      return null;
    } else {
      return '* Debes aceptar T&C!';
    }
  }

  void changeAcceptTermConditions({required bool newValue}) =>
      status = status.copyWith(acceptTermCoditions: newValue);

  void changeEmail(String email) =>
      status = status.copyWith(isEmailFieldEmpty: email.isEmpty);

  void changeNickName(String nickName) =>
      status = status.copyWith(isNickNameFieldEmpty: nickName.isEmpty);

  void changeFirstName(String firstName) =>
      status = status.copyWith(isFirstNameFieldEmpty: firstName.isEmpty);

  void changeFirstLastName(String firstLastName) => status =
      status.copyWith(isFirstLastNameFieldEmpty: firstLastName.isEmpty);

  void changeSecondName(String secondName) =>
      status = status.copyWith(isSecondNameFieldEmpty: secondName.isEmpty);

  void changeSecondLastName(String secondLastName) => status =
      status.copyWith(isSecondLastNameFieldEmpty: secondLastName.isEmpty);

  void changePhone(String phone) =>
      status = status.copyWith(isPhoneFieldEmpty: phone.isEmpty);

  void changePassword(String password) =>
      status = status.copyWith(isPasswordFieldEmpty: password.isEmpty);

  void changeConfirmPass(String confirmPass) =>
      status = status.copyWith(isConfirmPassFieldEmpty: confirmPass.isEmpty);

  bool isPasswordValid(String password, [int minLength = 7]) {
    final bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    final bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final bool hasMinLength = password.length > minLength;
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));

    status = status.copyWith(
      hasMore8Chars: hasMinLength,
      hasUpperLetter: hasUppercase,
      hasSpecialChar: hasSpecialCharacters,
      hasLowerLetter: hasLowercase,
      hasNumberChar: hasDigits,
    );
    return hasMinLength &
        hasUppercase &
        hasSpecialCharacters &
        hasLowercase &
        hasDigits;
  }

  // void hasMore8Chars({String psw = ''}) {
  //   status = status.copyWith(hasMore8Chars: psw.length >7 );
  // }

  Future<void> onInit({bool validateNotification = false}) async {}

  // void goHome(BuildContext context) {
  //   LdConnection.validateConnection().then((bool isConnectionValidvalue) {
  //     if (value) {
  //       _route.goHome(context);
  //     } else {
  //       // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
  //     }
  //   });
  // }
  void hidePassword() => status = status.copyWith(
        hidePass: !status.hidePass,
      );

  void setDateBirth(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now().subtract(const Duration(days: 36500)),
      maxTime: DateTime.now().subtract(const Duration(days: 6570)),
      onChanged: (DateTime date) {
        print('change $date');
      },
      onConfirm: (DateTime date) {
        final String dateT = date.toLocal().toString().split(' ').first;
        status =
            status.copyWith(isDateBirthFieldEmpty: date.toString().isEmpty);
        status.dateBirthCtrl.text = dateT;

        print('confirm ${date.toUtc()}');
        print('confirm ${status.dateBirthCtrl.text}');
      },
      currentTime: DateTime.now().subtract(const Duration(days: 10500)),
      locale: LocaleType.es,
    );
  }

  void goEnterPin(BuildContext context, String email) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        status = status.copyWith(emailRegister: email, indexStep: 2);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void requiredPinForEmailValidation(String email) {
    status = status.copyWith(
      isLoading: true,
    );
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        status = status.copyWith(
          emailRegister: email,
        );
        sendPinEmail(email);
        goNextStep(currentStep: 1);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
      status = status.copyWith(
        isLoading: false,
      );
    });
  }

  Future<void> validateCodePin(
    String codePin,
  ) async {
    status = status.copyWith(
      isLoading: true,
    );

    final EntityValidatePin entityValidatePin = EntityValidatePin(
      // "id": "string",  FALTAN ESTOS CAMPOS
      // "clientId": "string",
      numberOrEmail: status.emailRegister,
      otp: codePin,
    );
    final BodyValidatePin bodyValidatePin = BodyValidatePin(
      entity: entityValidatePin,
    );

    _interactor.validatePin(bodyValidatePin).then((
      ResponseData<ResultValidatePin> response,
    ) {
      if (response.isSuccess) {
        print('CodigoPin Validado con EXITOSO!!');
        goNextStep(currentStep: 4);
      } else {
        // TODO: Mostrar alerta
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      print('Validate codePIn Error As: $err');
      status = status.copyWith(isLoading: false);
    });
  }

  Future<void> sendPinEmail(
    String email,
  ) async {
    status = status.copyWith(
      isLoading: true,
      emailRegister: email,
    );

    final EntityPinEmail entityPin = EntityPinEmail(
      clientId: '2955cb39-61da-46ea-b503-42cb33831c8a',
      numberOrEmail: email,
      codevia: '2955cb39-61da-46ea-b503-42cb33831c8a',
      accountSid: 'AC9b9a39dbfa35ec8d06c6779ae463673c',
      authToken: '207f158a1ebcdd065e7195e49a7c4542',
    );
    final BodyPinEmail bodyPin = BodyPinEmail(
      entity: entityPin,
    );

    _interactor.sendPinValidateEmail(bodyPin).then((
      ResponseData<ResultPinEmail> response,
    ) {
      if (response.isSuccess) {
        print('pin email EXITOSO!!');
        // goNextStep(currentStep: 1);
      } else {
        // TODO: Mostrar alerta
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      print('Envio de Codigo Error As: $err');
      status = status.copyWith(isLoading: false);
    });
  }

  void goNextStep({
    required int currentStep,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        status = status.copyWith(
          indexStep: status.indexStep + 1,
        );
        // _route.goPersonalInfoRegister(context);
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
    required String emailRegister,
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
            email: emailRegister,
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
      dateBirth: dateBirth,
      email: email,
      phone: phone,
      userTypeId: '9c2f4526-5933-4404-96fc-784a87a7b674',
      password: password,
      isActive: true,
      addressWallet: '',
    );

    _interactor
        .postRegisterUser(bodyRegister)
        .then((ResponseData<ResultRegister> response) {
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

// Future<void> openEmail(BuildContext context) async {
//   final OpenMailAppResult result = await OpenMailApp.openMailApp();
//   if (!result.didOpen && !result.canOpen) {
//     // showNoMailAppsDialog(context);
//   } else if (!result.didOpen && result.canOpen) {
//     status = status.copyWith(isPossibleOpenEmail: true);
//   }
// }

}
