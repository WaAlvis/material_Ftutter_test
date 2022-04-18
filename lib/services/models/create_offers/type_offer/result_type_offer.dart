import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offers/type_offer/data.dart';

part 'result_type_offer.g.dart';

@JsonSerializable()
class ResultTypeOffer {
  ResultTypeOffer({
    required this.data,
  });

  factory ResultTypeOffer.fromJson(Map<String, dynamic> json) =>
      _$ResultTypeOfferFromJson(json);

  List<Data> data;

  Map<String, dynamic> toJson() => _$ResultTypeOfferToJson(this);
}
