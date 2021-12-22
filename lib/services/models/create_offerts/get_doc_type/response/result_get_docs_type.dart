import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/get_doc_type/response/type_doc.dart';

part 'result_get_banks.g.dart';

@JsonSerializable()
class ResultGetBanks {
  ResultGetBanks({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ResultGetBanks.fromJson(Map<String, dynamic> json) =>
      _$ResultGetBanksFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  List<TypeDoc> data;
  int totalItems;
  int totalPages;

  Map<String, dynamic> toJson() => _$ResultGetBanksToJson(this);
}
