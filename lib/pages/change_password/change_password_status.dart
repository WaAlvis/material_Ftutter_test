import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/pages/settings/ui/settings_view.dart';
import 'package:localdaily/view_model.dart';

class ChangePasswordStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final Language currentLanguage;

  ChangePasswordStatus({
    required this.isLoading,
    required this.currentLanguage,
    required this.isError,
  });

  ChangePasswordStatus copyWith(
      {bool? isLoading,
      Language? currentLanguage,
      List<DayOperation>? dayMockOpr,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return ChangePasswordStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }
}
