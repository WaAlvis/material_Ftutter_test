import 'package:flutter/material.dart';
import 'package:localdaily/view_model.dart';

class LoginStatus extends ViewStatus {
  final bool isLoading;
  // final bool isError;
  final bool hidePass;
  final bool errorLogin;

  LoginStatus({
    required this.errorLogin,
    required this.isLoading,
    // required this.isError,
    required this.hidePass,
  });

  LoginStatus copyWith({
    bool? errorLogin,
    bool? isLoading,
    // bool? isError,
    bool? hidePass,
  }) {
    return LoginStatus(
      errorLogin: errorLogin ?? this.errorLogin,
      isLoading: isLoading ?? this.isLoading,
      // isError: isError ?? this.isError,
      hidePass: hidePass ?? this.hidePass,
    );
  }
}
