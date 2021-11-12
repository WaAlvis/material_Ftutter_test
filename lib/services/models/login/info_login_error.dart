import 'package:json_annotation/json_annotation.dart';

part 'info_login_error.g.dart';

@JsonSerializable()
class InfoLoginError{
  InfoLoginError({required this.timeUnlock, this.attemps});

  factory InfoLoginError.fromJson(Map<String, dynamic> json) =>
      _$InfoLoginErrorFromJson(json);

  String timeUnlock;
  String? attemps;

  Map<String, dynamic> toJson() => _$InfoLoginErrorToJson(this);
}