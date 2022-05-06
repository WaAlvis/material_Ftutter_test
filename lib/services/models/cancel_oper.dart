import 'package:json_annotation/json_annotation.dart';

part 'cancel_oper.g.dart';

@JsonSerializable()
class CancelOper {
  CancelOper({
    required this.advertisementId,
  });

  factory CancelOper.fromJson(Map<String, dynamic> json) =>
      _$CancelOperFromJson(json);

  String advertisementId;

  Map<String, dynamic> toJson() => _$CancelOperToJson(this);
}
