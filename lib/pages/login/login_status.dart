import 'package:localdaily/view_model.dart';

class LoginStatus extends ViewStatus {
  final bool isLoading;

  // final bool isError;
  final bool hidePass;
  final bool errorLogin;
  final bool isEmailFieldEmpty;
  final bool isPswFieldEmpty;

  LoginStatus({
    required this.errorLogin,
    required this.isLoading,
    // required this.isError,
    required this.hidePass,
    required this.isEmailFieldEmpty,
    required this.isPswFieldEmpty,
  });

  LoginStatus copyWith({
    bool? errorLogin,
    bool? isLoading,
    // bool? isError,
    bool? hidePass,
    bool? isEmailFieldEmpty,
    bool? isPswFieldEmpty,
  }) {
    return LoginStatus(
      isPswFieldEmpty: isPswFieldEmpty ?? this.isPswFieldEmpty,
      isEmailFieldEmpty: isEmailFieldEmpty ?? this.isEmailFieldEmpty,
      errorLogin: errorLogin ?? this.errorLogin,
      isLoading: isLoading ?? this.isLoading,
      // isError: isError ?? this.isError,
      hidePass: hidePass ?? this.hidePass,
    );
  }
}
