import 'package:localdaily/services/models/create_offerts/getBanks/response/result_get_banks.dart';
import 'package:localdaily/view_model.dart';

class OffertBuyStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  ResultGetBanks listBanks;

  OffertBuyStatus({
    required this.isLoading,
    required this.isError,
    required this.listBanks,
  });

  OffertBuyStatus copyWith({
    bool? isLoading,
    bool? isError,
    ResultGetBanks? listBanks,
  }) {
    return OffertBuyStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      listBanks: listBanks ?? this.listBanks,
    );
  }
}
