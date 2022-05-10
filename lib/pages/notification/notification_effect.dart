import 'package:localdaily/view_model.dart';

abstract class NotificationEffect extends Effect {}

class SnackbarConnectivityEffect extends NotificationEffect {
  final String message;

  SnackbarConnectivityEffect(this.message);
}

class SnackbarErrorEffect extends NotificationEffect {
  final String message;

  SnackbarErrorEffect(this.message);
}
