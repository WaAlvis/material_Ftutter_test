import 'package:localdaily/view_model.dart';

class RecoverPswStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final bool isEmailFieldEmpty;

  RecoverPswStatus(
      {required this.isLoading,
      required this.isError,
      required this.isEmailFieldEmpty});

  RecoverPswStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? isEmailFieldEmpty,
  }) {
    return RecoverPswStatus(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        isEmailFieldEmpty: isEmailFieldEmpty ?? this.isEmailFieldEmpty);
  }
}
