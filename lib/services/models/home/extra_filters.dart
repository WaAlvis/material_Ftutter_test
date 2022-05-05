import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extra_filters.g.dart';

@JsonSerializable()
class ExtraFilters {
  ExtraFilters({
    this.range,
    this.dateExpiry,
    this.rate,
    this.bank,
    this.status,
  });

  factory ExtraFilters.fromJson(Map<String, dynamic> json) =>
      _$ExtraFiltersFromJson(json);

  int? range;
  List<double>? rate;
  int? dateExpiry;
  String? bank;
  String? status;
  Map<String, dynamic> toJson() => _$ExtraFiltersToJson(this);
}
