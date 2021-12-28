import 'package:localdaily/view_model.dart';

class RegisterStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final String emailRegister;
  final int indexStep;

  RegisterStatus({
    required this.isLoading,
    required this.isError,
    required this.emailRegister,
    required this.indexStep,
  });

  RegisterStatus copyWith({
    bool? isLoading,
    bool? isError,
    String? emailRegister,
    int? indexStep,
  }) {
    return RegisterStatus(
      indexStep: indexStep ?? this.indexStep,
      isLoading: isLoading ?? this.isLoading,
      emailRegister: emailRegister ?? this.emailRegister,
      isError: isError ?? this.isError,
    );
  }
}
