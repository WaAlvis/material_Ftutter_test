import 'package:localdaily/view_model.dart';

class BuySellStatus extends ViewStatus{

  final bool isLoading;
  final bool isError;

  BuySellStatus({required this.isLoading, required this.isError});

  BuySellStatus copyWith({bool? isLoading, bool? isError}) {
    return BuySellStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
