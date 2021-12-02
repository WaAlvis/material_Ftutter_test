import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/bank.dart';

part 'result_get_banks.g.dart';

@JsonSerializable()
class ResultGetBanks {
  ResultGetBanks({
    this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ResultGetBanks.fromJson(Map<String, dynamic> json) =>
      _$ResultGetBanksFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  List<Bank>? data;
  int totalItems;
  int totalPages;

  Map<String, dynamic> toJson() => _$ResultGetBanksToJson(this);
}
