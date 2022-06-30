import 'package:localdaily/view_model.dart';

abstract class SettingsUpdateEffect extends Effect {}

class ShowDialogSettingsUpdateEffect extends SettingsUpdateEffect {}

class ShowSnackbarConnectivityEffect extends SettingsUpdateEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowErrorSnackbar extends SettingsUpdateEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}

class ShowSuccessSnackbar extends SettingsUpdateEffect {
  final String message;

  ShowSuccessSnackbar(this.message);
}

class ShowWarningSnackbar extends SettingsUpdateEffect {
  final String message;

  ShowWarningSnackbar(this.message);
}
