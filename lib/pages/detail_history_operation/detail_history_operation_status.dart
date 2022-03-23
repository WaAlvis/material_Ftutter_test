import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/view_model.dart';

class DetailHistoryOperation extends ViewStatus {
  final bool isLoading;
  final bool isError;

  DetailHistoryOperation({
    required this.isLoading,
    required this.isError,
  });

  DetailHistoryOperation copyWith(
      {bool? isLoading,
      List<DayOperation>? dayMockOpr,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return DetailHistoryOperation(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
