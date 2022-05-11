import 'package:json_annotation/json_annotation.dart';

part 'result_notification_counter.g.dart';

@JsonSerializable()
class ResultNotificationCounter {
  ResultNotificationCounter({
    required this.notificationsUnread,
  });

  factory ResultNotificationCounter.fromJson(Map<String, dynamic> json) =>
      _$ResultNotificationCounterFromJson(json);

  int notificationsUnread;

  Map<String, dynamic> toJson() => _$ResultNotificationCounterToJson(this);
}
