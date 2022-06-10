import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/pages/settings_update/ui/settings_update_view.dart';
import 'package:localdaily/view_model.dart';

class SettingsUpdateStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final Language currentLanguage;

  SettingsUpdateStatus({
    required this.isLoading,
    required this.currentLanguage,
    required this.isError,
  });

  SettingsUpdateStatus copyWith(
      {bool? isLoading,
      Language? currentLanguage,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return SettingsUpdateStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }
}
