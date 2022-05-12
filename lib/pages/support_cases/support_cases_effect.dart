import 'package:localdaily/view_model.dart';

abstract class SupportCasesEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends SupportCasesEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowSnackbarErrorEffect extends SupportCasesEffect {
  final String message;

  ShowSnackbarErrorEffect(this.message);
}
