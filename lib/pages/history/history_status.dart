import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/models/history_operations_user/response/advertisement.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/view_model.dart';

class HistoryStatus extends ViewStatus {
  final bool isLoading;
  final bool isDataEmpty;
  // final bool allLoaded;
  final bool isError;
  late List<GroupAdvertisement> operationsForDay;
  late List<DataUserAdvertisement> listHistoryOperations;

  HistoryStatus({
    required this.isLoading,
    this.isDataEmpty= false,
    required this.isError,
    // required this.allLoaded,
    required this.operationsForDay,
    required this.listHistoryOperations,
  });

  HistoryStatus copyWith({
    bool? isLoading,
    bool? isDataEmpty,
    List<GroupAdvertisement>? operationsForDay,
    bool? isError,
    // bool? allLoaded,
    List<DataUserAdvertisement>? listHistoryOperations,
  }) {
    return HistoryStatus(
      isDataEmpty: isDataEmpty ?? this.isDataEmpty,
      operationsForDay: operationsForDay ?? this.operationsForDay,
      // allLoaded: allLoaded ?? this.allLoaded,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      listHistoryOperations:
          listHistoryOperations ?? this.listHistoryOperations,
    );
  }
}
