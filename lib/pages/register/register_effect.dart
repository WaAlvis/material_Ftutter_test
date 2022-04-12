import 'package:localdaily/view_model.dart';

abstract class RegisterEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends RegisterEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowDialogRegisterEffect extends RegisterEffect {}

class ShowSnackbarDisconnect extends RegisterEffect {}
