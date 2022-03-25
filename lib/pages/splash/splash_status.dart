import 'package:localdaily/view_model.dart';

class SplashStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  SplashStatus({
    required this.isLoading,
    required this.isError,
  });

  SplashStatus copyWith({
    bool? isLoading,
    bool? isError,
  }) {
    return SplashStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
