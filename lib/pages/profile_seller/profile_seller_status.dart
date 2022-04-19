import 'package:localdaily/view_model.dart';

class ProfileSellerStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;

  ProfileSellerStatus({
    required this.isLoading,
    required this.isError,
  });

  ProfileSellerStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? hidePass,
    bool? isEmailFieldEmpty,
    bool? isPswFieldEmpty,
  }) {
    return ProfileSellerStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
