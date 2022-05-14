import 'package:flutter/material.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/view_model.dart';

class FilterStatus extends ViewStatus {
  final bool isLoading;
  final ResultGetBanks resultGetBanks;
  final List<String>? banks;
  final int? dateExpiry;
  final int? range;
  final RangeValues? selectRange;
  final int? status;

  FilterStatus({
    required this.isLoading,
    required this.resultGetBanks,
    this.banks,
    this.dateExpiry,
    this.range,
    this.selectRange,
    this.status,
  });
  FilterStatus copyWith({
    bool? isLoading,
    ResultGetBanks? resultGetBanks,
    List<String>? banks,
    int? dateExpiry,
    int? range,
    RangeValues? selectRange,
    int? status,
  }) {
    return FilterStatus(
      isLoading: isLoading ?? this.isLoading,
      resultGetBanks: resultGetBanks ?? this.resultGetBanks,
      banks: banks ?? this.banks,
      dateExpiry: dateExpiry ?? this.dateExpiry,
      range: range ?? this.range,
      selectRange: selectRange ?? this.selectRange,
      status: status ?? this.status,
    );
  }
}
