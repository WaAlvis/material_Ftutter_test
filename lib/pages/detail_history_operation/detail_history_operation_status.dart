import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/view_model.dart';

import '../../services/models/history_operations_user/response/data_user_advertisement.dart';

class DetailHistoryOperationStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  // final DataUserAdvertisement dataUserAdvertisement;
  late ResultDataUser? userBuyer;

  DetailHistoryOperationStatus({
    required this.isLoading,
    required this.isError,
    // required this.dataUserAdvertisement,
     this.userBuyer,
  });

  DetailHistoryOperationStatus copyWith({
    // DataUserAdvertisement? dataUserAdvertisement,
    bool? isLoading,
    bool? isError,
    bool? isLoadingOperations,
    bool? allLoaded,
    ResultDataUser? userBuyer,
  }) {
    return DetailHistoryOperationStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      // dataUserAdvertisement:
      //     dataUserAdvertisement ?? this.dataUserAdvertisement,
      userBuyer: userBuyer ?? this.userBuyer,
    );
  }
}
