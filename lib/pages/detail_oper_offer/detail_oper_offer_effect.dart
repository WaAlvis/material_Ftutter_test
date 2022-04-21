import 'package:localdaily/view_model.dart';

abstract class DetailOperOfferEffect extends Effect {}

class ValidateOperOffer extends DetailOperOfferEffect {}

class ShowSnackConnetivityEffect extends DetailOperOfferEffect {
  final String message;
  ShowSnackConnetivityEffect(this.message);
}

class ShowSnackbarSuccesEffect extends DetailOperOfferEffect {
  ShowSnackbarSuccesEffect();
}

class ShowSnackbarErrorEffect extends DetailOperOfferEffect {
  final String message;
  ShowSnackbarErrorEffect(this.message);
}
