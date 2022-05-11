import 'package:localdaily/view_model.dart';

abstract class ChangePswEffect extends Effect {}

class ShowDialogRegisterEffect extends ChangePswEffect {}
class ShowSnackbarConnectivityEffect extends ChangePswEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowErrorSnackbar extends ChangePswEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}

class ShowSuccessSnackbar extends ChangePswEffect {
  final String message;

  ShowSuccessSnackbar(this.message);
}

class ShowWarningSnackbar extends ChangePswEffect {
  final String message;

  ShowWarningSnackbar(this.message);
}

