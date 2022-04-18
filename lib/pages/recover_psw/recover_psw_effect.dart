import 'package:localdaily/view_model.dart';

abstract class RecoverPswEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends RecoverPswEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowDialogRecoverPswEffect extends RecoverPswEffect {}

class ShowSnackbarRecoverPswEffect extends RecoverPswEffect {}
