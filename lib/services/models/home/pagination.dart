import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  Pagination({
    required this.isPaginable,
    required this.currentPage,
    required this.itemsPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  bool isPaginable;
  int currentPage;
  int itemsPerPage;

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
