import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/view_model.dart';

class HistoryStatus extends ViewStatus {
  final bool isLoading;
  final bool isLoadingHistory;
  final bool allLoaded;
  final bool isError;
  final List<DayOperation> daysMockHistory;

  HistoryStatus({
    required this.isLoading,
    required this.daysMockHistory,
    required this.isError,
    required this.isLoadingHistory,
    required this.allLoaded,
  });

  HistoryStatus copyWith(
      {bool? isLoading,
      List<DayOperation>? dayMockOpr,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return HistoryStatus(
      daysMockHistory: dayMockOpr ?? this.daysMockHistory,
      allLoaded: allLoaded ?? this.allLoaded,
      isLoadingHistory: isLoadingOperations ?? this.isLoadingHistory,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
