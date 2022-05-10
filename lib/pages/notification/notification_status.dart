import 'package:localdaily/services/models/notifications/result_notification.dart';
import 'package:localdaily/view_model.dart';

class NotificationStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final ResultNotification resultNotification;

  NotificationStatus({
    required this.isLoading,
    required this.isError,
    required this.resultNotification,
  });

  NotificationStatus copyWith({
    bool? isLoading,
    bool? isError,
    ResultNotification? resultNotification,
  }) {
    return NotificationStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      resultNotification: resultNotification ?? this.resultNotification,
    );
  }
}
