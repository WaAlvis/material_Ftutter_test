import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/result_get_banks.dart';
import 'package:localdaily/view_model.dart';

class OffertBuyStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  ResultGetBanks listBanks;
  final Bank? selectedBank;

  final String valueCalculate;

  OffertBuyStatus({
    required this.selectedBank,
    required this.valueCalculate,
    required this.isLoading,
    required this.isError,
    required this.listBanks,
  });

  OffertBuyStatus copyWith({
    bool? isLoading,
    bool? isError,
    ResultGetBanks? listBanks,
    String? valueCalculate,
    Bank? selectedBank,
  }) {
    return OffertBuyStatus(
      selectedBank: selectedBank ?? this.selectedBank,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      listBanks: listBanks ?? this.listBanks,
      valueCalculate: valueCalculate ?? this.valueCalculate,
    );
  }
}
