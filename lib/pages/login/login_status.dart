import 'package:localdaily/view_model.dart';

class LoginStatus extends ViewStatus {
  final bool isLoading;
  final bool hidePass;
  final bool isError;
  final bool isEmailFieldEmpty;
  final bool isPswFieldEmpty;

  LoginStatus({
    required this.isLoading,
    required this.isError,
    required this.hidePass,
    required this.isEmailFieldEmpty,
    required this.isPswFieldEmpty,
  });

  LoginStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? hidePass,
    bool? isEmailFieldEmpty,
    bool? isPswFieldEmpty,
  }) {
    return LoginStatus(
      isPswFieldEmpty: isPswFieldEmpty ?? this.isPswFieldEmpty,
      isEmailFieldEmpty: isEmailFieldEmpty ?? this.isEmailFieldEmpty,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      hidePass: hidePass ?? this.hidePass,
    );
  }
}
