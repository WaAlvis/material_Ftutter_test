import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/view_model.dart';

class DetailOfferBuyStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  // final String valueCalculate;

  DetailOfferBuyStatus({
    required this.isLoading,
    required this.isError,
  });

  DetailOfferBuyStatus copyWith({
    bool? isLoading,
    bool? isError,
  }) {
    return DetailOfferBuyStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      // valueCalculate: valueCalculate ?? this.valueCalculate,
    );
  }
}
