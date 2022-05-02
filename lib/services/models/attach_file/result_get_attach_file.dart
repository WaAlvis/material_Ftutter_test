import 'package:json_annotation/json_annotation.dart';

part 'result_get_attach_file.g.dart';

@JsonSerializable()
class ResultGetDataAttach {
  ResultGetDataAttach({
    required this.isSuccess,
    required this.statusCode,
    required this.result,
    required this.error,
  });
  factory ResultGetDataAttach.fromJson(Map<String, dynamic> json) =>
      _$ResultGetDataAttachFromJson(json);
  bool isSuccess;
  int statusCode;
  String result;
  dynamic error;

  Map<String, dynamic> toJson() => _$ResultGetDataAttachToJson(this);
}
