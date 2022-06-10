import 'package:localdaily/view_model.dart';

class ContactSupportStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final bool isBuy;
  final bool isDisputa;
  final String description;

  ContactSupportStatus({
    required this.isLoading,
    required this.isError,
    required this.isBuy,
    required this.isDisputa,
    required this.description,
  });

  ContactSupportStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? isBuy,
    bool? isDisputa,
    String? description,
    String? mobile,
  }) {
    return ContactSupportStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isBuy: isBuy ?? this.isBuy,
      isDisputa: isDisputa ?? this.isDisputa,
      description: description ?? this.description,
    );
  }
}
