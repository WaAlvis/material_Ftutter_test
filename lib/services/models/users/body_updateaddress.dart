import 'package:json_annotation/json_annotation.dart';

part 'body_updateaddress.g.dart';

@JsonSerializable()
class BodyUpdateAddress {
  BodyUpdateAddress({required this.idUser, required this.addressWallet});
  factory BodyUpdateAddress.fromJson(Map<String, dynamic> json) =>
      _$BodyUpdateAddressFromJson(json);

  String idUser;
  String addressWallet;

  Map<String, dynamic> toJson() => _$BodyUpdateAddressToJson(this);
}
