import 'package:localdaily/view_model.dart';

abstract class InfoViewEffect extends Effect {}

class ShowSnackConnetivityEffect extends InfoViewEffect {
  final String message;
  ShowSnackConnetivityEffect(this.message);
}

class ShowSnackbarSuccesEffect extends InfoViewEffect {
  ShowSnackbarSuccesEffect();
}

class ShowSnackbarErrorEffect extends InfoViewEffect {
  final String message;
  ShowSnackbarErrorEffect(this.message);
}

class ShowLoadingEffect extends InfoViewEffect {}
