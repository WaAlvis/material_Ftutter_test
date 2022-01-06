import 'package:flutter/material.dart';
import 'package:localdaily/view_model.dart';

class RegisterStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final String emailRegister;
  final int indexStep;
  final TextEditingController dateBirthCtrl;
  final bool isEmailFieldEmpty;

  RegisterStatus({
    required this.dateBirthCtrl,
    required this.isLoading,
    required this.isError,
    required this.emailRegister,
    required this.indexStep,
    required this.isEmailFieldEmpty,
  });

  RegisterStatus copyWith({
    TextEditingController? dateBirthCtrl,
    bool? isLoading,
    bool? isError,
    String? emailRegister,
    int? indexStep,
    bool? isEmailFieldEmpty,
  }) {
    return RegisterStatus(
      isEmailFieldEmpty: isEmailFieldEmpty ?? this.isEmailFieldEmpty,
      dateBirthCtrl: dateBirthCtrl ?? this.dateBirthCtrl,
      indexStep: indexStep ?? this.indexStep,
      isLoading: isLoading ?? this.isLoading,
      emailRegister: emailRegister ?? this.emailRegister,
      isError: isError ?? this.isError,
    );
  }
}
