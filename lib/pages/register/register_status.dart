import 'package:flutter/material.dart';
import 'package:localdaily/view_model.dart';

enum RegisterStep {
  emailStep_1,
  msjEmailStep_2,
  validatePinStep_3,
  accountDataStep_4,
  personalDataStep_5,
  dataWalletStep_6
}

class RegisterStatus extends ViewStatus {
  final bool isLoading;
  final bool hidePass;
  final bool isError;
  final bool acceptTermCoditions;
  final bool hasMore8Chars;
  final bool hasUpperLetter;
  final bool hasSpecialChar;
  final bool hasLowerLetter;
  final bool hasNumberChar;
  final String emailRegister;
  final String addressWallet;
  final String nickName;
  late String password;
  final RegisterStep registerStep;
  final TextEditingController dateBirthCtrl;
  final bool isEmailFieldEmpty;
  final bool isNickNameFieldEmpty;
  final bool isFirstNameFieldEmpty;
  final bool isFirstLastNameFieldEmpty;
  final bool isSecondNameFieldEmpty;
  final bool isSecondLastNameFieldEmpty;
  final bool isPhoneFieldEmpty;
  final bool isDateBirthFieldEmpty;
  final bool isPasswordFieldEmpty;
  final bool isConfirmPassFieldEmpty;
  final String phrase;
  final String surnames;
  final String names;
  final String dateBirth;
  final String phone;
  final bool isPossibleOpenEmail; //Verificar uso necesario?

  RegisterStatus({
    required this.phrase,
    required this.isPossibleOpenEmail,
    required this.addressWallet,
    required this.nickName,
    required this.password,
    required this.acceptTermCoditions,
    required this.dateBirthCtrl,
    required this.isLoading,
    required this.isError,
    required this.emailRegister,
    required this.registerStep,
    required this.isEmailFieldEmpty,
    required this.isNickNameFieldEmpty,
    required this.isFirstNameFieldEmpty,
    required this.isFirstLastNameFieldEmpty,
    required this.isSecondNameFieldEmpty,
    required this.isSecondLastNameFieldEmpty,
    required this.isPhoneFieldEmpty,
    required this.isDateBirthFieldEmpty,
    required this.isPasswordFieldEmpty,
    required this.isConfirmPassFieldEmpty,
    required this.hidePass,
    required this.hasSpecialChar,
    required this.hasMore8Chars,
    required this.hasUpperLetter,
    required this.hasLowerLetter,
    required this.hasNumberChar,
    required this.surnames,
    required this.names,
    required this.dateBirth,
    required this.phone,
  });

  RegisterStatus copyWith({
    TextEditingController? dateBirthCtrl,
    bool? isLoading,
    bool? isError,
    String? emailRegister,
    String? addressWallet,
    String? nickName,
    String? names,
    String? surnames,
    String? password,
    String? dateBirth,
    String? phone,
    RegisterStep? registerStep,
    bool? acceptTermCoditions,
    bool? isEmailFieldEmpty,
    bool? isNickNameFieldEmpty,
    bool? isFirstNameFieldEmpty,
    bool? isFirstLastNameFieldEmpty,
    bool? isSecondNameFieldEmpty,
    bool? isSecondLastNameFieldEmpty,
    bool? isPhoneFieldEmpty,
    bool? isDateBirthFieldEmpty,
    bool? isPasswordFieldEmpty,
    bool? isConfirmPassFieldEmpty,
    bool? isPossibleOpenEmail,
    bool? hidePass,
    bool? hasSpecialChar,
    bool? hasUpperLetter,
    bool? hasMore8Chars,
    bool? hasLowerLetter,
    bool? hasNumberChar,
    String? phrase,
  }) {
    return RegisterStatus(
      phone: phone ?? this.phone,
      addressWallet: addressWallet ?? this.addressWallet,
      dateBirth: dateBirth ?? this.dateBirth,
      names: names ?? this.names,
      surnames: surnames ?? this.surnames,
      phrase: phrase ?? this.phrase,
      nickName: nickName ?? this.nickName,
      password: password ?? this.password,
      hidePass: hidePass ?? this.hidePass,
      isNickNameFieldEmpty: isNickNameFieldEmpty ?? this.isNickNameFieldEmpty,
      isFirstNameFieldEmpty:
          isFirstNameFieldEmpty ?? this.isFirstNameFieldEmpty,
      isFirstLastNameFieldEmpty:
          isFirstLastNameFieldEmpty ?? this.isFirstLastNameFieldEmpty,
      isSecondNameFieldEmpty:
          isSecondNameFieldEmpty ?? this.isSecondNameFieldEmpty,
      isSecondLastNameFieldEmpty:
          isSecondLastNameFieldEmpty ?? this.isSecondLastNameFieldEmpty,
      isPhoneFieldEmpty: isPhoneFieldEmpty ?? this.isPhoneFieldEmpty,
      isDateBirthFieldEmpty:
          isDateBirthFieldEmpty ?? this.isDateBirthFieldEmpty,
      isPasswordFieldEmpty: isPasswordFieldEmpty ?? this.isPasswordFieldEmpty,
      isConfirmPassFieldEmpty:
          isConfirmPassFieldEmpty ?? this.isConfirmPassFieldEmpty,
      isPossibleOpenEmail: isPossibleOpenEmail ?? this.isPossibleOpenEmail,
      isEmailFieldEmpty: isEmailFieldEmpty ?? this.isEmailFieldEmpty,
      dateBirthCtrl: dateBirthCtrl ?? this.dateBirthCtrl,
      registerStep: registerStep ?? this.registerStep,
      isLoading: isLoading ?? this.isLoading,
      emailRegister: emailRegister ?? this.emailRegister,
      isError: isError ?? this.isError,
      hasMore8Chars: hasMore8Chars ?? this.hasMore8Chars,
      hasUpperLetter: hasUpperLetter ?? this.hasUpperLetter,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      acceptTermCoditions: acceptTermCoditions ?? this.acceptTermCoditions,
      hasLowerLetter: hasLowerLetter ?? this.hasLowerLetter,
      hasNumberChar: hasNumberChar ?? this.hasNumberChar,
    );
  }
}
