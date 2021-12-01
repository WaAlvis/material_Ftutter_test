 import 'package:localdaily/view_model.dart';

class RegisterStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  RegisterStatus({required this.isLoading, required this.isError});

  RegisterStatus copyWith({bool? isLoading, bool? isError}) {
    return RegisterStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
