import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/pages/settings_update/ui/settings_update_view.dart';
import 'package:localdaily/view_model.dart';

class SettingsUpdateStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final bool isNickNameFieldEmpty;

  SettingsUpdateStatus({
    required this.isLoading,
    required this.isError,
    required this.isNickNameFieldEmpty,
  });

  SettingsUpdateStatus copyWith(
      {bool? isLoading,
      bool? isNickNameFieldEmpty,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return SettingsUpdateStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isNickNameFieldEmpty: isNickNameFieldEmpty ?? this.isNickNameFieldEmpty,
    );
  }
}
