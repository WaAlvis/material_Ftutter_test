import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/models/history_operations_user/response/advertisement.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/view_model.dart';

class HistoryStatus extends ViewStatus {
  final bool isLoading;
  final bool allLoaded;
  final bool isError;
  final List<DataUserAdvertisement> operations;
  final List<DayOperation> daysMockHistory;
  final List<GroupAdvertisement> operationsForDay;

  HistoryStatus({
    required this.isLoading,
    required this.operations,
    required this.daysMockHistory,
    required this.isError,
    required this.allLoaded,
    required this.operationsForDay,
  });

  HistoryStatus copyWith({
    bool? isLoading,
    List<DataUserAdvertisement>? operations,
    List<GroupAdvertisement>? operationsForDay,
    List<DayOperation>? daysMockHistory,
    bool? isError,
    bool? allLoaded,
  }) {
    return HistoryStatus(
      operationsForDay: operationsForDay ?? this.operationsForDay,
      operations: operations ?? this.operations,
      daysMockHistory: daysMockHistory ?? this.daysMockHistory,
      allLoaded: allLoaded ?? this.allLoaded,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
