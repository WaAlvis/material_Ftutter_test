import 'package:localdaily/view_model.dart';

class HistoryStatus extends ViewStatus{

  final bool isLoading;
  final bool isError;

  HistoryStatus({required this.isLoading, required this.isError});

  HistoryStatus copyWith({bool? isLoading, bool? isError}) {
    return HistoryStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
