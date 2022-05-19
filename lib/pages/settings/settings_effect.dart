import 'package:localdaily/view_model.dart';

abstract class SettingEffect extends Effect {}

class ShowDialogSettingEffect extends SettingEffect {}

class ShowSnackbarConnectivityEffect extends SettingEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

// class ShowErrorSnackbar extends SettingEffect {
//   final String message;
//
//   ShowErrorSnackbar(this.message);
// }

// class ShowSuccessSnackbar extends SettingEffect {
//   final String message;
//
//   ShowSuccessSnackbar(this.message);
// }

// class ShowWarningSnackbar extends SettingEffect {
//   final String message;
//
//   ShowWarningSnackbar(this.message);
// }
