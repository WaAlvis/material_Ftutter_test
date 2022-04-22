import 'package:localdaily/view_model.dart';

class NotificationStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  NotificationStatus({required this.isLoading, required this.isError});

  NotificationStatus copyWith({
    bool? isLoading,
    bool? isError,
  }) {
    return NotificationStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
