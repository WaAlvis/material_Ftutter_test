import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/pagination.dart';

part 'body_notifications.g.dart';

@JsonSerializable()
class BodyNotifications {
  BodyNotifications({
    required this.idUser,
    required this.pagination,
  });

  factory BodyNotifications.fromJson(Map<String, dynamic> json) =>
      _$BodyNotificationsFromJson(json);

  String idUser;
  Pagination pagination;

  Map<String, dynamic> toJson() => _$BodyNotificationsToJson(this);
}
