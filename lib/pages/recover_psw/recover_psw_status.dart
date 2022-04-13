import 'package:localdaily/view_model.dart';

class RecoverPswStatus extends ViewStatus {
  final bool isLoading;

  final bool isError;


  RecoverPswStatus({
    required this.isLoading,
    required this.isError,
  });

  RecoverPswStatus copyWith({
    bool? isLoading,
    bool? isError,
  }) {
    return RecoverPswStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
