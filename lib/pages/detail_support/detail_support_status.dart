import 'package:localdaily/pages/detail_support/ui/detail_support_view.dart';
import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/view_model.dart';

class DetailSupportStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final BodyContactSupport advertisement;

  DetailSupportStatus(
      {required this.isLoading,
      required this.isError,
      required this.advertisement});

  DetailSupportStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? isLoadingOperations,
    bool? allLoaded,
    BodyContactSupport? advertisement,
  }) {
    return DetailSupportStatus(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        advertisement: advertisement ?? this.advertisement);
  }
}
