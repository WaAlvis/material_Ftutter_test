import 'package:localdaily/view_model.dart';

class DetailOperOfferStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final dynamic item;
  final String dateOfExpire;
  // agregar demas estados con el servicio

  DetailOperOfferStatus({
    required this.isLoading,
    required this.isError,
    required this.item,
    required this.dateOfExpire,
  });

  DetailOperOfferStatus copyWith({
    String? dateOfExpire,
    bool? isLoading,
    bool? isError,
    dynamic? item,
  }) {
    return DetailOperOfferStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      item: item ?? this.item,
      dateOfExpire: dateOfExpire ?? this.dateOfExpire,
    );
  }
}
