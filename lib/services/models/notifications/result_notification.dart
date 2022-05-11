import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/notifications/notification.dart';

part 'result_notification.g.dart';

@JsonSerializable()
class ResultNotification {
  ResultNotification({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ResultNotification.fromJson(Map<String, dynamic> json) =>
      _$ResultNotificationFromJson(json);

  List<NotificationP> data;
  int totalItems;
  int totalPages;

  Map<String, dynamic> toJson() => _$ResultNotificationToJson(this);
}
