import 'package:localdaily/services/models/create_offerts/getBanks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/result_get_banks.dart';
import 'package:localdaily/view_model.dart';

class OffertSaleStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  ResultGetBanks listBanks;

  OffertSaleStatus({
    required this.isLoading,
    required this.isError,
    required this.listBanks,
  });

  OffertSaleStatus copyWith({
    bool? isLoading,
    bool? isError,
    ResultGetBanks? listBanks,
  }) {
    return OffertSaleStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      listBanks: listBanks ?? this.listBanks,
    );
  }
}
