import 'package:json_annotation/json_annotation.dart';

part 'confirm_payment.g.dart';

@JsonSerializable()
class ConfirmPayment {
  ConfirmPayment({
    required this.idAvertisement,
    required this.addressDestiny,
    required this.value,
    required this.message,
  });

  factory ConfirmPayment.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentFromJson(json);

  String idAvertisement;
  String addressDestiny;
  String value;
  String message;

  Map<String, dynamic> toJson() => _$ConfirmPaymentToJson(this);
}
