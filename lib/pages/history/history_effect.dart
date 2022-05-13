import 'package:localdaily/pages/detail_offer/detail_offer_effect.dart';
import 'package:localdaily/view_model.dart';

abstract class LoginEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends LoginEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowDialogHomeEffect extends LoginEffect {}

class DialogFailAttempsLogin extends LoginEffect {
  // final String test;

  DialogFailAttempsLogin();
}

class ShowErrorSnackbar extends LoginEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}
