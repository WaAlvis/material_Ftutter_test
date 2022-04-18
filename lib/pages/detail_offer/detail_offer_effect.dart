import 'package:localdaily/view_model.dart';

abstract class DetailOfferEffect extends Effect {}

class ValidateOfferEffect extends DetailOfferEffect {}

class ShowSnackbarConnectivityEffect extends DetailOfferEffect {
  final String message;
  ShowSnackbarConnectivityEffect(this.message);
}

class ShowSnackbarSuccesEffect extends DetailOfferEffect {
  ShowSnackbarSuccesEffect();
}

class ShowSnackbarErrorEffect extends DetailOfferEffect {
  final String message;
  ShowSnackbarErrorEffect(this.message);
}
