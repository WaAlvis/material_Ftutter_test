import 'package:localdaily/view_model.dart';

class RegisterStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final String emailRegister;

  RegisterStatus({
    required this.isLoading,
    required this.isError,
    required this.emailRegister,
  });

  RegisterStatus copyWith({
    bool? isLoading,
    bool? isError,
    String? emailRegister,
  }) {
    return RegisterStatus(
      isLoading: isLoading ?? this.isLoading,
      emailRegister: emailRegister ?? this.emailRegister,
      isError: isError ?? this.isError,
    );
  }
}
