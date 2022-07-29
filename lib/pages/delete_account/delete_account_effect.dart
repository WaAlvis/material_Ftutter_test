import 'package:localdaily/view_model.dart';

abstract class DeleteAccountEffect extends Effect {}

class ShowDialogDeleteAccountEffect extends DeleteAccountEffect {}

class ShowSnackbarConnectivityEffect extends DeleteAccountEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowErrorSnackbar extends DeleteAccountEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}

class DialogConfirmDeleteAccount extends DeleteAccountEffect {
  DialogConfirmDeleteAccount();
}

class ShowDeleteConfirmSnackbar extends DeleteAccountEffect {
  final String message;

  ShowDeleteConfirmSnackbar(this.message);
}

class ShowSuccessSnackbar extends DeleteAccountEffect {
  final String message;

  ShowSuccessSnackbar(this.message);
}

class ShowWarningSnackbar extends DeleteAccountEffect {
  final String message;

  ShowWarningSnackbar(this.message);
}

