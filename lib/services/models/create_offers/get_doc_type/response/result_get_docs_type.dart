import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';

part 'result_get_docs_type.g.dart';

@JsonSerializable()
class ResultGetDocsType {
  ResultGetDocsType({
    required this.data,
    required this.totalItems,
    required this.totalPages,
  });

  factory ResultGetDocsType.fromJson(Map<String, dynamic> json) =>
      _$ResultGetDocsTypeFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  List<DocType> data;
  int totalItems;
  int totalPages;

  Map<String, dynamic> toJson() => _$ResultGetDocsTypeToJson(this);
}
