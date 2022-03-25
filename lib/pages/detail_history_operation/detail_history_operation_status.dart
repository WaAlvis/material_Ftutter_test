import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/view_model.dart';

class DetailHistoryOperationStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  DetailHistoryOperationStatus({
    required this.isLoading,
    required this.isError,
  });

  DetailHistoryOperationStatus copyWith(
      {bool? isLoading,
      List<DayOperation>? dayMockOpr,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return DetailHistoryOperationStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
