import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/result_get_banks.dart';
import 'package:localdaily/view_model.dart';

class DetailOfferBuyStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  ResultGetBanks listBanks;
  final Bank? selectedBank;
  final String totalMoney;
  final bool isMarginEmpty;

  // final String valueCalculate;

  DetailOfferBuyStatus({
    required this.totalMoney,
    required this.selectedBank,
    required this.isMarginEmpty,
    required this.isLoading,
    required this.isError,
    required this.listBanks,
  });

  DetailOfferBuyStatus copyWith({
    String? totalMoney,
    bool? isLoading,
    bool? isError,
    bool? isMarginEmpty,
    ResultGetBanks? listBanks,
    // String? valueCalculate,
    Bank? selectedBank,
  }) {
    return DetailOfferBuyStatus(
      isMarginEmpty: isMarginEmpty?? this.isMarginEmpty,
      totalMoney: totalMoney ?? this.totalMoney,
      selectedBank: selectedBank ?? this.selectedBank,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      listBanks: listBanks ?? this.listBanks,
      // valueCalculate: valueCalculate ?? this.valueCalculate,
    );
  }
}
