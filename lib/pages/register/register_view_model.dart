import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hex/hex.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
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
import 'package:bip39/bip39.dart';
import 'package:web3dart/web3dart.dart' as web3;

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
      surnames: '',
      phrase: '',
      phone: '',
      dateBirth: '',
      names: '',
      addressWallet: '',
    );
  }

  Future<void> onInit({bool validateNotification = false}) async {}

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

  void hidePassword() => status = status.copyWith(
        hidePass: !status.hidePass,
      );

  void onChangePhrase(String value) {
    status = status.copyWith(phrase: value);
  }

  void getWalletAddressFromMnemonic(String mnemonic) {
    if (!validateMnemonic(mnemonic)) throw 'Invalid mnemonic';

    final Uint8List seed = mnemonicToSeed(mnemonic);
    final BIP32 node = BIP32.fromSeed(seed);
    final BIP32 child = node.derivePath("m/44'/60'/0'/0/0");

    final web3.EthereumAddress address =
        web3.EthPrivateKey.fromHex(HEX.encode(child.privateKey!)).address;

    final String addressUser = address.hex.toLowerCase();
    status = status.copyWith(addressWallet: addressUser);
  }

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

  // void goEnterPin(BuildContext context, String email) {
  //   LdConnection.validateConnection().then((bool isConnectionValidvalue) {
  //     if (isConnectionValidvalue) {
  //       status = status.copyWith(emailRegister: email, registerStep: RegisterStep.msjEmailStep_2);
  //     } else {
  //       // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
  //     }
  //   });
  // }
// NEXT STEP////////////////////////
  void continueStep_2MsjEmail(String email) =>
      requiredPinForEmailValidation(email); //fin step 1
  void continueStep_3ValidatePin() => continueValidatePin(); //fin step 2
  void continueStep_4AccountData(
    String codePin,
  ) =>
      validatedCodePin(codePin); //fin step 3
  void continueStep_5PersonalData(String nick, String psw) =>
      registerAccountData(
        nick,
        psw,
      ); //fin step 4
  void continueStep_6RestoreWallet(
    String name,
    String surname,
    String dateBirth,
    String phone,
  ) =>
      savePersonalData(name, surname, dateBirth, phone); //fin step 5
  void validateAddress(String phrase) => getWalletAddressFromMnemonic(phrase);

  void finishRegister(
    BuildContext context,
    DataUserProvider dataUserProvider,
  ) =>
      registerUser(context, dataUserProvider: dataUserProvider); //fin step 5

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
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
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
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
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
      if (response.isSuccess && response.result!.valid) {
        print('CodigoPin Validado con EXITOSO!!');
        goNextStep(currentStep: RegisterStep.validatePinStep_3);
      } else {
        // TODO: Mostrar alerta
        // addEffect(ShowSnackbarPinInvalid);
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      print('Validate codePIn Error As: $err');
      status = status.copyWith(isLoading: false);
    });
  }

  Future<void> reSendPinToEmail(String email) => sendPinToEmail(email);

  Future<void> sendPinToEmail(
    String email,
  ) async {
    status = status.copyWith(
      isLoading: true,
      emailRegister: email,
    );

    final EntityPinEmail entityPin = EntityPinEmail(
      numberOrEmail: email,
      codevia: 'cf1c420a-38bd-44b0-8187-fbf1e91ad21a',
    );
    final BodyPinEmail bodyPin = BodyPinEmail(
      entity: entityPin,
    );

    _interactor.requestPinValidateEmail(bodyPin).then((
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
          case RegisterStep.personalDataStep_5:
            nextStep = RegisterStep.dataWalletStep_6;
            break;
          default: // Without this, you see a WARNING.
            print(currentStep);
        }
        status = status.copyWith(
          registerStep: nextStep,
        );
        // _route.goPersonalInfoRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  Future<void> registerAccountData(
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

  Future<void> registerUser(
    BuildContext context, {
    required DataUserProvider dataUserProvider,
  }) async {
    status = status.copyWith(isLoading: true);
    final String sha256pass = encrypPass(status.password).toString();
    // print('pass256 $sha256pass');

    final BodyRegisterDataUser bodyRegister = BodyRegisterDataUser(
      nickName: status.nickName,
      firstName: status.names,
      secondName: '',
      firstLastName: status.surnames,
      secondLastName: '',
      dateBirth: status.dateBirth,
      email: status.emailRegister,
      phone: status.phone,
      userTypeId: '9c2f4526-5933-4404-96fc-784a87a7b674',
      password: status.password,
      isActive: true,
      addressWallet: status.addressWallet,
    );

    _interactor
        .postRegisterUser(bodyRegister)
        .then((ResponseData<ResultRegister> response) {
      print('Register Res: ${response.statusCode} ');
      if (response.isSuccess) {
        final String idUser = response.result!.id;
        _interactor
            .getUserById(idUser)
            .then((ResponseData<ResultDataUser> response) {
          if (response.isSuccess) {
            print('Registro EXITOSO + User guardado completps!!');
            dataUserProvider.setDataUserLogged(
              response.result,
            );
            _route.goHome(context);
          }
        }).catchError((err) {
          status = status.copyWith(
            isError: true,
          );
          print('Login DataFull Error As: ${err}');
          status = status.copyWith(isLoading: false);
        });
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

  //   VALIDATORS    /////////////////////////
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
