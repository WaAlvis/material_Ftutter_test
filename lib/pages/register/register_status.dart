import 'package:flutter/material.dart';
import 'package:localdaily/view_model.dart';

class RegisterStatus extends ViewStatus {
  final bool isLoading;
  final bool hidePass;
  final bool isError;
  final bool acceptTermCoditions;
  final String emailRegister;
  final int indexStep;
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
  final bool isPossibleOpenEmail; //Verificar uso necesario?

  RegisterStatus({
    required this.isPossibleOpenEmail,
    required this.acceptTermCoditions,
    required this.dateBirthCtrl,
    required this.isLoading,
    required this.isError,
    required this.emailRegister,
    required this.indexStep,
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
  });

  RegisterStatus copyWith({
    TextEditingController? dateBirthCtrl,
    bool? isLoading,
    bool? isError,
    String? emailRegister,
    int? indexStep,
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
  }) {
    return RegisterStatus(
      acceptTermCoditions: acceptTermCoditions??this.acceptTermCoditions,
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
      indexStep: indexStep ?? this.indexStep,
      isLoading: isLoading ?? this.isLoading,
      emailRegister: emailRegister ?? this.emailRegister,
      isError: isError ?? this.isError,
    );
  }
}
