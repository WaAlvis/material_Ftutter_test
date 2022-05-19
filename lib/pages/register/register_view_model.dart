import 'dart:convert';

import 'package:country_code_picker/country_code.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/info/ui/info_view.dart';
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

import 'register_status.dart';

class RegisterViewModel
    extends EffectsViewModel<RegisterStatus, RegisterEffect> {
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
      // isError: false,
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
      // isErrorRegisterUser: false,
      // msjErrorRegisterUser: '',
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
      validateCodePin(codePin); //fin step 3
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
    LdConnection.validateConnection().then((bool isConnectionValid) async {
      if (isConnectionValid) {
        await sendPinToEmail(email);
        //Todo DESACTIVAR, cuando sea efectivo el envio de codigo al correo
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void continueValidatePin() {
    //fin step 2
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        goNextStep(currentStep: RegisterStep.msjEmailStep_2);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void validateCodePin(
    String codePin,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        validatedPin(codePin);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> validatedPin(
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
          addEffect(ShowSuccessSnackbar('Pin validado con éxito'));
          goNextStep(
            currentStep: RegisterStep.validatePinStep_3,
          );
        } else {
          addEffect(ShowWarningSnackbar('Codigo incorrecto'));
        }
      } else {
        addEffect(ShowWarningSnackbar('Error en la validación'));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      addEffect(ShowErrorSnackbar('Error servicio**'));
      status = status.copyWith(isLoading: false);
    });
  }

  Future<void> reSendPinToEmail(String email) =>
      sendPinToEmail(email, againSend: true);

  Future<void> sendPinToEmail(String email, {bool againSend = false}) async {
    status = status.copyWith(
      isLoading: true,
      emailRegister: email,
    );

    final BodyPinEmail bodyPinEmail = BodyPinEmail(
      clientId: 'f160e3d8-aca1-4c5b-a7df-c07a858013cd',
      numberOrEmail: email,
      codevia: 'cf1c420a-38bd-44b0-8187-fbf1e91ad21a',
    );

    _interactor.requestPinValidateEmail(bodyPinEmail).then((
      ResponseData<ResultPinEmail> response,
    ) {
      if (response.isSuccess) {
        addEffect(ShowSuccessSnackbar('Código enviado'));
        if (!againSend) {
          goNextStep(currentStep: RegisterStep.emailStep_1);
        }
      } else {
        addEffect(ShowWarningSnackbar('Error en el envio'));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      addEffect(ShowErrorSnackbar('Error servicio**'));
      status = status.copyWith(isLoading: false);
    });
  }

  void goNextStep({
    required RegisterStep currentStep,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
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
    LdConnection.validateConnection().then(
      (bool isConnectionValid) {
        if (isConnectionValid) {
          status = status.copyWith(nickName: nickName, password: password);
          goNextStep(currentStep: RegisterStep.accountDataStep_4);
        } else {
          addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
        }
      },
    );
  }

  String? textError({required String errorMsj}) {
    const String start = 'Detail="';
    const String end = '")';
    final int startIndex = errorMsj.indexOf(start);
    final int endIndex = errorMsj.indexOf(end, startIndex + start.length);
    final Map<String, String> types = <String, String>{
      'the nickname is already in use': 'El nombre de usuario ya esta en uso',
      'the phone is already registered': 'El celular ya esta en uso',
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
    LdConnection.validateConnection().then(
      (bool isConnectionValid) {
        if (isConnectionValid) {
          registerUserService(
            context,
            dataUserProvider,
            names,
            surnames,
            dateBirth,
            phone,
          );
        } else {
          addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
        }
      },
    );
  }

  Future<void> registerUserService(
    BuildContext context,
    DataUserProvider dataUserProvider,
    String names,
    String surnames,
    String dateBirth,
    String phone,
  ) async {
    final String sha256passWord = encryptionPass(status.password).toString();
    status = status.copyWith(isLoading: true);

    final BodyRegisterDataUser bodyRegister = BodyRegisterDataUser(
      nickName: status.nickName,
      firstName: names,
      secondName: '',
      firstLastName: surnames,
      secondLastName: '',
      dateBirth: status.dateBirth,
      email: status.emailRegister,
      indicative: int.parse(status.indicativePhone.replaceFirst('+', '')),
      phone: phone,
      userTypeId: '9c2f4526-5933-4404-96fc-784a87a7b674',
      password: sha256passWord,
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
        final String idUser = response.result!.id;
        _interactor
            .getUserById(idUser)
            .then((ResponseData<ResultDataUser> responseDataUser) async {
          if (responseDataUser.isSuccess) {
            dataUserProvider.setDataUserLogged(
              responseDataUser.result,
            );
            status = status.copyWith(
              isErrorPinValidate: false,
            );
            goSuccessRegister(context);
          } else {
            addEffect(ShowErrorSnackbar('Error en almacenando la info'));
          }
          status = status.copyWith(isLoading: false);
        }).catchError((Object err) {
          addEffect(ShowErrorSnackbar('Error servicio**'));
          status = status.copyWith(
            isLoading: false,
          );
        });
      } else {
        final String err = textError(
              errorMsj: response.error!.message,
            ) ??
            'Error en el registro';
        addEffect(ShowWarningSnackbar(err));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      addEffect(ShowErrorSnackbar('Error servicio**'));
      status = status.copyWith(
        isLoading: false,
      );
    });
  }

  void goSuccessRegister(BuildContext context) {
    final InfoViewArguments info = InfoViewArguments(
      actionCaption: 'Ingresar',
      title: '¡Felciitaciones!',
      colorTitle: LdColors.white,
      description: 'Ya tienes una cuenta. Es hora de comprar y vender tus DLY.',
      onAction: () => _route.goHome(context),
    );
    _route.goInfoView(context, info);
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
    if (value.length < 7) {
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

  String? validatorNotEmptyPin(String? pin) {
    {
      if (pin == null || pin.isEmpty) {
        return '* Código necesario';
      } else if (pin.length < 6) {
        return '* Código incompleto';
      }
      return null;
    }
  }

  String? validatorNickName(String? str) {
    if (str == null || str.isEmpty) {
      return '* Campo necesario';
    }
    if (str.length < 8 || str.length > 35) {
      return '* Minímo 8 y máximo 35 caracteres';
    }
    return null;
  }

  String? validatorMax50chars(String? str) {
    if (str == null || str.isEmpty) {
      return '* Campo necesario';
    }
    if (str.length > 50) {
      return '* máximo 50 caracteres';
    }

    return null;
  }

  String? validatorNotEmpty(String? str) {
    if (str == null || str.isEmpty) {
      return '* Campo necesario';
    }
    return null;
  }

  String? validateBirthday(String? value) {
    if (value == '' || value == null) {
      return '* Tu fecha de nacimiento es necesaria';
    }
    return null;
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
//     // showNoMailAppsDia|(context);
//   } else if (!result.didOpen && result.canOpen) {
//     status = status.copyWith(isPossibleOpenEmail: true);
//   }
// }

}
