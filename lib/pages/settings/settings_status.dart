import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/pages/settings/ui/settings_view.dart';
import 'package:localdaily/view_model.dart';

class SettingsStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final Language currentLanguage;

  SettingsStatus({
    required this.isLoading,
    required this.currentLanguage,
    required this.isError,
  });

  SettingsStatus copyWith(
      {bool? isLoading,
      Language? currentLanguage,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return SettingsStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }
}
