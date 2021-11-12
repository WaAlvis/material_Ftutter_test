import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/converter/ld_converter.dart';
import 'package:localdaily/services/models/response_error.dart';

part 'response_data.g.dart';

@JsonSerializable()
class ResponseData<T>{

  ResponseData({required this.isSuccess, required this.statusCode,
    this.result, this.error,
  });
  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);


  bool isSuccess;
  int statusCode;
  @LdConverter()
  T? result;
  ResponseError? error;

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}