import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/view_model.dart';

class DetailOfferBuyStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final Data item;
  final String dateOfExpire;

  // final String valueCalculate;

  DetailOfferBuyStatus({
    required this.dateOfExpire,
    required this.isLoading,
    required this.isError,
    required this.item,
  });

  DetailOfferBuyStatus copyWith({
    String? dateOfExpire,
    bool? isLoading,
    bool? isError,
    Data? item,
  }) {
    return DetailOfferBuyStatus(
      item: item ?? this.item,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      dateOfExpire: dateOfExpire ?? this.dateOfExpire,
      // valueCalculate: valueCalculate ?? this.valueCalculate,
    );
  }
}
