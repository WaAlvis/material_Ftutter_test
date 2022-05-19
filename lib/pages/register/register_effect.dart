import 'package:localdaily/view_model.dart';

abstract class RegisterEffect extends Effect {}

class ShowDialogRegisterEffect extends RegisterEffect {}
class ShowSnackbarConnectivityEffect extends RegisterEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowErrorSnackbar extends RegisterEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}

class ShowSuccessSnackbar extends RegisterEffect {
  final String message;

  ShowSuccessSnackbar(this.message);
}

class ShowWarningSnackbar extends RegisterEffect {
  final String message;

  ShowWarningSnackbar(this.message);
}
