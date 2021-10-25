import 'package:localdaily/view_model.dart';

class LoginStatus extends ViewStatus{

  final bool isLoading;
  final bool isError;

  LoginStatus({required this.isLoading, required this.isError});

  LoginStatus copyWith({bool? isLoading, bool? isError}) {
    return LoginStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
