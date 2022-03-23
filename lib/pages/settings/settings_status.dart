import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/view_model.dart';

class SettingsStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  SettingsStatus({
    required this.isLoading,
    required this.isError,
  });

  SettingsStatus copyWith(
      {bool? isLoading,
      List<DayOperation>? dayMockOpr,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return SettingsStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
