import 'package:localdaily/pages/detail_support/ui/detail_support_view.dart';
import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/view_model.dart';

class DetailSupportStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final Language currentLanguage;

  DetailSupportStatus({
    required this.isLoading,
    required this.currentLanguage,
    required this.isError,
  });

  DetailSupportStatus copyWith(
      {bool? isLoading,
      Language? currentLanguage,
      bool? isError,
      bool? isLoadingOperations,
      bool? allLoaded}) {
    return DetailSupportStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }
}
