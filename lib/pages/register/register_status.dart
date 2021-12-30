import 'package:flutter/material.dart';
import 'package:localdaily/view_model.dart';

class RegisterStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final String emailRegister;
  final int indexStep;
  final TextEditingController dateBirthCtrl;

  RegisterStatus({
    required this.dateBirthCtrl,
    required this.isLoading,
    required this.isError,
    required this.emailRegister,
    required this.indexStep,
  });

  RegisterStatus copyWith({
    TextEditingController? dateBirthCtrl,
    bool? isLoading,
    bool? isError,
    String? emailRegister,
    int? indexStep,
  }) {
    return RegisterStatus(
      dateBirthCtrl: dateBirthCtrl??this.dateBirthCtrl,
      indexStep: indexStep ?? this.indexStep,
      isLoading: isLoading ?? this.isLoading,
      emailRegister: emailRegister ?? this.emailRegister,
      isError: isError ?? this.isError,
    );
  }
}
