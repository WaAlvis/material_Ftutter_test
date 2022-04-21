import 'package:json_annotation/json_annotation.dart';

part 'body_recover_psw.g.dart';

@JsonSerializable()
class BodyRecoverPsw {
  BodyRecoverPsw({
    required this.filter,
    required this.document,
    required this.signature,
    required this.codeLang,

  });

  factory BodyRecoverPsw.fromJson(Map<String, dynamic> json) =>
      _$BodyRecoverPswFromJson(json);

  String filter;
  String document;
  String signature;
  String codeLang;

  Map<String, dynamic> toJson() => _$BodyRecoverPswToJson(this);
}
