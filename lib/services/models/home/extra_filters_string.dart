import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extra_filters_string.g.dart';

@JsonSerializable()
class ExtraFiltersString {
  ExtraFiltersString({
    this.range,
    this.dateExpiry,
    // this.rate,
    this.bank,
    this.status,
  });

  factory ExtraFiltersString.fromJson(Map<String, dynamic> json) =>
      _$ExtraFiltersStringFromJson(json);

  String? range;
  // String? rate;
  String? dateExpiry;
  String? bank;
  String? status;
  Map<String, dynamic> toJson() => _$ExtraFiltersStringToJson(this);
}
