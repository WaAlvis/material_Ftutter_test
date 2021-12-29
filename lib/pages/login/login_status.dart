import 'package:localdaily/view_model.dart';

class LoginStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final bool hidePass;

  LoginStatus({
    required this.isLoading,
    required this.isError,
    required this.hidePass,
  });

  LoginStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? hidePass,
  }) {
    return LoginStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      hidePass: hidePass ?? this.hidePass,
    );
  }
}
