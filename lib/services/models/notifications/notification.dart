import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationP {
  NotificationP({
    required this.id,
    required this.idUser,
    required this.identifierCode,
    required this.tittle,
    required this.message,
    required this.createDate,
    required this.isRead,
    required this.isPublishNotification,
    required this.isPendingNotification,
    required this.isPayNotification,
    required this.isClosingNotification,
    required this.isSupportNotification,
    required this.isExpirationDate,
  });

  factory NotificationP.fromJson(Map<String, dynamic> json) =>
      _$NotificationPFromJson(json);

  String id;
  String idUser;
  String identifierCode;
  String tittle;
  String message;
  int createDate;
  bool isRead;
  bool isPublishNotification;
  bool isPendingNotification;
  bool isPayNotification;
  bool isClosingNotification;
  bool isSupportNotification;
  bool isExpirationDate;

  Map<String, dynamic> toJson() => _$NotificationPToJson(this);
}
