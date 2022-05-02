import 'package:localdaily/view_model.dart';

abstract class AttachedFileEffect extends Effect {}

class ValidateAttahcedFileEffect extends AttachedFileEffect {}

class ShowSnackConnetivityEffect extends AttachedFileEffect {
  final String message;
  ShowSnackConnetivityEffect(this.message);
}

class ShowSnackbarSuccesEffect extends AttachedFileEffect {
  final String message;
  ShowSnackbarSuccesEffect(this.message);
}

class ShowSnackbarErrorEffect extends AttachedFileEffect {
  final String message;
  ShowSnackbarErrorEffect(this.message);
}

class ShowLoadingEffect extends AttachedFileEffect {}
