import 'package:localdaily/view_model.dart';

abstract class HomeEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends HomeEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowDialogHomeEffect extends HomeEffect {}

class ShowSnackbarDisconnect extends HomeEffect {}
