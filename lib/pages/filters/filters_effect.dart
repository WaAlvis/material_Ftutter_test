import 'package:localdaily/view_model.dart';

abstract class FilterEffect extends Effect {}

class ValidateFilter extends FilterEffect {}

class ShowSnackConnetivityEffect extends FilterEffect {
  final String message;
  ShowSnackConnetivityEffect(this.message);
}

class ShowSnackbarSuccesEffect extends FilterEffect {
  ShowSnackbarSuccesEffect();
}

class ShowSnackbarErrorEffect extends FilterEffect {
  final String message;
  ShowSnackbarErrorEffect(this.message);
}

class ShowLoadingEffect extends FilterEffect {}
