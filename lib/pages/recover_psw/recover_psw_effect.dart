import 'package:localdaily/view_model.dart';

abstract class RecoverPswEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends RecoverPswEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowDialogRecoverPswEffect extends RecoverPswEffect {}

class ShowSuccessSnackbar extends RecoverPswEffect {
  final String message;

  ShowSuccessSnackbar(this.message);
}

class ShowWarningSnackbar extends RecoverPswEffect {
  final String message;

  ShowWarningSnackbar(this.message);
}

class ShowErrorSnackbar extends RecoverPswEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}
