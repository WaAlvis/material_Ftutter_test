import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/converter/ld_converter.dart';
import 'package:localdaily/services/models/login/info_login_error.dart';

part 'response_error.g.dart';

@JsonSerializable()
class ResponseError<T>{
  ResponseError({required this.message, this.info});

  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorFromJson(json);

  String message;
  @LdConverter()
  T? info;

  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
}
