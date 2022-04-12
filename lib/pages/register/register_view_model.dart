import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart';
import 'package:bip39/bip39.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hex/hex.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/register/register_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
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
import 'package:web3dart/web3dart.dart' as web3;

import 'register_status.dart';

class RegisterViewModel extends EffectsViewModel<RegisterStatus, RegisterEffect> {
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
      registerStep: RegisterStep.emailStep_1,
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
      password: '',
      nickName: '',
      dateBirth: '',
      isErrorPinValidate: false,
      isErrorRegisterUser: false,
      msjErrorRegisterUser: '',
      indicativePhone: '+57',
      // surnames: '',
      // phrase: '',
      // phone: '',
      // dateBirth: '',
      // names: '',
      // addressWallet: '',
    );
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void changeIndicative(CountryCode value) =>
      status = status.copyWith(indicativePhone: value.dialCode);

  void changePhone(String phone) =>
      status = status.copyWith(isPhoneFieldEmpty: phone.isEmpty);

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

  void changePassword(String password) =>
      status = status.copyWith(isPasswordFieldEmpty: password.isEmpty);

  void changeConfirmPass(String confirmPass) =>
      status = status.copyWith(isConfirmPassFieldEmpty: confirmPass.isEmpty);

  void hidePassword() => status = status.copyWith(
        hidePass: !status.hidePass,
      );

  void onChangePhrase(String value) {
    status = status.copyWith(phrase: value);
  }

  void setDateBirth(DateTime? date) {
    final String dateT = date!.toLocal().toString().split(' ').first;
    status = status.copyWith(
        isDateBirthFieldEmpty: date.toString().isEmpty, dateBirth: dateT);
    status.dateBirthCtrl.text = dateT;
  }

  void continueStep_2MsjEmail(String email) =>
      requiredPinForEmailValidation(email); //fin step 1
  void continueStep_3ValidatePin() => continueValidatePin(); //fin step 2
  void continueStep_4AccountData(
    String codePin,
  ) =>
      validatedCodePin(codePin); //fin step 3
  void continueStep_5PersonalData(String nick, String psw) =>
      registerNickPswUser(
        nick,
        psw,
      ); //fin step 4

  void finishRegister(
    BuildContext context,
    DataUserProvider dataUserProvider,
    String names,
    String surnames,
    String dateBirth,
    String phone,
  ) =>
      registerUser(
        context,
        dataUserProvider,
        names,
        surnames,
        dateBirth,
        phone,
      ); //fin step 5

  void requiredPinForEmailValidation(String email) {
    //fin step 1
    status = status.copyWith(
      isLoading: true,
    );
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        status = status.copyWith(
          emailRegister: email,
        );
        sendPinToEmail(email);
        goNextStep(currentStep: RegisterStep.emailStep_1);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
      status = status.copyWith(
        isLoading: false,
      );
    });
  }

  void continueValidatePin() {
    //fin step 2
    status = status.copyWith(
      isLoading: true,
    );
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        goNextStep(currentStep: RegisterStep.msjEmailStep_2);
      } else {

        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));

      }
      status = status.copyWith(
        isLoading: false,
      );
    });
  }

  Future<void> validatedCodePin(
    //fin step 3
    String codePin,
  ) async {
    status = status.copyWith(
      isLoading: true,
    );

    final EntityValidatePin entityValidatePin = EntityValidatePin(
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
        if (response.result!.valid) {
          status = status.copyWith(
            isErrorPinValidate: false,
          );
          goNextStep(
            currentStep: RegisterStep.validatePinStep_3,
          );
        } else {
          status = status.copyWith(
            isErrorPinValidate: true,
          );
        }
      } else {
        // TODO: Mostrar alerta
        // addEffect(ShowSnackbarPinInvalid);
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      print('Validate codePin Error As: $err');
      status = status.copyWith(isLoading: false);
    });
  }

  Future<void> reSendPinToEmail(String email) => sendPinToEmail(email);

  void closeErrMsgPinValid() {
    status = status.copyWith(isErrorPinValidate: false);
  }

  void closeErrMsgRegisterUser() {
    status = status.copyWith(isErrorRegisterUser: false);
  }

  Future<void> sendPinToEmail(
    String email,
  ) async {
    status = status.copyWith(
      isLoading: true,
      emailRegister: email,
    );

    final EntityPinEmail entityPin = EntityPinEmail(
      numberOrEmail: email,
      codevia: 'cf1c420a-38bd-44b0-8187-fbf1e91ad21a', //Email
    );
    final BodyPinEmail bodyPin = BodyPinEmail(
      entity: entityPin,
    );

    _interactor.requestPinValidateEmail(bodyPin).then((
      ResponseData<ResultPinEmail> response,
    ) {
      if (response.isSuccess) {
        print('Solicitud de pin email EXITOSO!!');
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
    required RegisterStep currentStep,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        late RegisterStep nextStep;

        switch (currentStep) {
          case RegisterStep.emailStep_1:
            nextStep = RegisterStep.msjEmailStep_2;
            break;
          case RegisterStep.msjEmailStep_2:
            nextStep = RegisterStep.validatePinStep_3;
            break;
          case RegisterStep.validatePinStep_3:
            nextStep = RegisterStep.accountDataStep_4;
            break;
          case RegisterStep.accountDataStep_4:
            nextStep = RegisterStep.personalDataStep_5;
            break;
          default: // Without this, you see a WARNING.
            print(currentStep);
        }
        status = status.copyWith(
          registerStep: nextStep,
        );
        // _route.goPersonalInfoRegister(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));

      }
    });
  }

  Future<void> registerNickPswUser(
    String nickName,
    String password,
  ) async {
    status = status.copyWith(isLoading: true);
    LdConnection.validateConnection().then(
      (bool value) {
        if (value) {
          status = status.copyWith(nickName: nickName, password: password);
          goNextStep(currentStep: RegisterStep.accountDataStep_4);
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    ).catchError((Object err) {
      print('Envio de Codigo Error As: $err');
      status = status.copyWith(isLoading: false);
    });
    status = status.copyWith(isLoading: false);
  }

  Future<void> savePersonalData(
      String name, String surname, String dateBirth, String phone) async {
    status = status.copyWith(isLoading: true);
    LdConnection.validateConnection().then(
      (bool value) {
        if (value) {
          status = status.copyWith(
            names: name,
            surnames: surname,
            dateBirth: dateBirth,
            phone: phone,
          );
          goNextStep(currentStep: RegisterStep.personalDataStep_5);
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    ).catchError((Object err) {
      print('Envio de Codigo Error As: $err');
      status = status.copyWith(isLoading: false);
    });
    status = status.copyWith(isLoading: false);
  }

  String? textError({required String errorMsj}) {
    const String start = 'Detail="';
    const String end = '")';
    final int startIndex = errorMsj.indexOf(start);
    final int endIndex = errorMsj.indexOf(end, startIndex + start.length);
    final Map<String, String> types = <String, String>{
      'the nickname is already in use': 'El nombre de usuario ya esta en uso',
      'the phone is already registered': 'El telefono ya esta en uso',
      'the mail is already registered': 'El email ya esta en uso',
    };
    final String detailError = errorMsj.substring(
      startIndex + start.length,
      endIndex,
    );

    return types[detailError];
  }

  Future<void> registerUser(
    BuildContext context,
    DataUserProvider dataUserProvider,
    String names,
    String surnames,
    String dateBirth,
    String phone,
  ) async {
    status = status.copyWith(isLoading: true);
    final String sha256pass = encryptionPass(status.password).toString();
    // print('pass256 $sha256pass');

    final BodyRegisterDataUser bodyRegister = BodyRegisterDataUser(
      nickName: status.nickName,
      firstName: names,
      secondName: '',
      firstLastName: surnames,
      secondLastName: '',
      dateBirth: status.dateBirth,
      email: status.emailRegister,
      phone: '${status.indicativePhone}$phone',
      userTypeId: '9c2f4526-5933-4404-96fc-784a87a7b674',
      password: status.password,
      isActive: true,
      addressWallet: '',
      dateTimeCreate: '',
      rateSeller: '',
      rateBuyer: '',
      isCorporative: false,
    );

    _interactor
        .postRegisterUser(bodyRegister)
        .then((ResponseData<ResultRegister> response) {
      if (response.isSuccess) {
        //todo
        final String idUser = response.result!.id;
        _interactor
            .getUserById(idUser)
            .then((ResponseData<ResultDataUser> responseDataUser) {
          if (responseDataUser.isSuccess) {
            print('Registro EXITOSO + User guardado completps!!');
            dataUserProvider.setDataUserLogged(
              responseDataUser.result,
            );
            status = status.copyWith(
                isError: false,
                isErrorPinValidate: false,
                isErrorRegisterUser: false);
            _route.goHome(context);
          }
        }).catchError((Object err) {
          status = status.copyWith(
            isError: true,
          );
          print('Login DataFull Error As: $err');
          status = status.copyWith(isLoading: false);
        });
      } else {
        status = status.copyWith(
          isErrorRegisterUser: true,
          msjErrorRegisterUser: textError(
            errorMsj: response.error!.message,
          ),
        );
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      print('Registro Error As: $err');
      status = status.copyWith(isLoading: false, isError: true);
    });
  }

  Digest encryptionPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }

  //   VALIDATORS    /////////////////////////

  String? validatePhone(String? value) {
    if (value == '' || value == null) {
      return 'El número de celular es necesario';
    }
    if (value.length < 10) {
      return 'El número esta incompleto';
    }
    return null;
  }

  String? validatorCheckBox({bool? valueCheck}) {
    if (valueCheck!) {
      return null;
    } else {
      return '* Debes aceptar T&C!';
    }
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

  String? validatorNotEmpty(String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo necesario';
      }
      return null;
    }
  }

  String? validateBirthday(String? value) {
    if (value == '') {
      return '* Tu fecha de nacimiento es necesaria';
    }
  }

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

// Future<void> openEmail(BuildContext context) async {
//   final OpenMailAppResult result = await OpenMailApp.openMailApp();
//   if (!result.didOpen && !result.canOpen) {
//     // showNoMailAppsDialog(context);
//   } else if (!result.didOpen && result.canOpen) {
//     status = status.copyWith(isPossibleOpenEmail: true);
//   }
// }

}
