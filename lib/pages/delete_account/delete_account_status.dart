import 'package:localdaily/view_model.dart';

class DeleteAccountStatus extends ViewStatus {
  final bool isLoading;
  final bool isCurrentPswFieldEmpty;
  final bool hidePass;


  DeleteAccountStatus({
    required this.isLoading,
    required this.isCurrentPswFieldEmpty,
    required this.hidePass,
  });

  DeleteAccountStatus copyWith({
    bool? isLoading,
    bool? isCurrentPswFieldEmpty,
    bool? hidePass,
  }) {
    return DeleteAccountStatus(
      isLoading: isLoading ?? this.isLoading,
      isCurrentPswFieldEmpty: isCurrentPswFieldEmpty ?? this.isCurrentPswFieldEmpty,
      hidePass: hidePass?? this.hidePass,
    );
  }
}
