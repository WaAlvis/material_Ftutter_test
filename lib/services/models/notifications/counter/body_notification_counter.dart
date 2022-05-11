import 'package:json_annotation/json_annotation.dart';

part 'body_notification_counter.g.dart';

@JsonSerializable()
class BodyNotificationCounter {
  BodyNotificationCounter({
    required this.idUser,
  });

  factory BodyNotificationCounter.fromJson(Map<String, dynamic> json) =>
      _$BodyNotificationCounterFromJson(json);

  String idUser;

  Map<String, dynamic> toJson() => _$BodyNotificationCounterToJson(this);
}
