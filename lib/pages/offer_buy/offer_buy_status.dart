import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/view_model.dart';

class OfferBuyStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  ResultGetBanks listBanks;
  final String totalMoney;
  final bool isMarginEmpty;

  OfferBuyStatus({
    required this.totalMoney,
    required this.isMarginEmpty,
    required this.isLoading,
    required this.isError,
    required this.listBanks,
  });

  OfferBuyStatus copyWith({
    String? totalMoney,
    bool? isLoading,
    bool? isError,
    bool? isMarginEmpty,
    ResultGetBanks? listBanks,
    Bank? selectedBank,
  }) {
    return OfferBuyStatus(
      isMarginEmpty: isMarginEmpty ?? this.isMarginEmpty,
      totalMoney: totalMoney ?? this.totalMoney,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      listBanks: listBanks ?? this.listBanks,
    );
  }
}
