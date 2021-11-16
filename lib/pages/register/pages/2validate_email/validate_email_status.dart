import 'package:localdaily/view_model.dart';

class ValidateEmailStatus extends ViewStatus{

  final bool isLoading;
  final bool isError;

  ValidateEmailStatus({required this.isLoading, required this.isError});

  ValidateEmailStatus copyWith({bool? isLoading, bool? isError}) {
    return ValidateEmailStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
