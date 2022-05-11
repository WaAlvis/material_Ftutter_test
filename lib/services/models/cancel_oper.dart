import 'package:json_annotation/json_annotation.dart';

part 'cancel_oper.g.dart';

@JsonSerializable()
class CancelOper {
  CancelOper({
    required this.idAvertisement,
  });

  factory CancelOper.fromJson(Map<String, dynamic> json) =>
      _$CancelOperFromJson(json);

  String idAvertisement;

  Map<String, dynamic> toJson() => _$CancelOperToJson(this);
}
