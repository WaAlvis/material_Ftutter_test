import 'package:localdaily/view_model.dart';

class RegisterUserStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  RegisterUserStatus({required this.isLoading, required this.isError});

  RegisterUserStatus copyWith({bool? isLoading, bool? isError}) {
    return RegisterUserStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
