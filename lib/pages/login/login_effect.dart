import 'package:localdaily/view_model.dart';

abstract class LoginEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends LoginEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowDialogHomeEffect extends LoginEffect {}

class ShowSnackbarErrorCredential extends LoginEffect {
  final String message;

  ShowSnackbarErrorCredential(this.message);
}



