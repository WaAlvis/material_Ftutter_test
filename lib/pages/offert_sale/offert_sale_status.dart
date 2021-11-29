import 'package:localdaily/view_model.dart';

class OffertSaleStatus extends ViewStatus{

  final bool isLoading;
  final bool isError;

  OffertSaleStatus({required this.isLoading, required this.isError});

  OffertSaleStatus copyWith({bool? isLoading, bool? isError}) {
    return OffertSaleStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
