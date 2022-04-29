import 'package:localdaily/view_model.dart';

class ContactSupportStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final bool isBuy;
  final String description;
  final String mobile;

  ContactSupportStatus({
    required this.isLoading,
    required this.isError,
    required this.isBuy,
    required this.description,
    required this.mobile,
  });

  ContactSupportStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? isBuy,
    String? description,
    String? mobile,
  }) {
    return ContactSupportStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isBuy: isBuy ?? this.isBuy,
      description: description ?? this.description,
      mobile: mobile ?? this.mobile,
    );
  }
}
