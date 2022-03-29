import 'package:localdaily/view_model.dart';

abstract class OfferBuyEffect extends Effect {}

class ValidateOfferEffect extends OfferBuyEffect {}

class ShowSnackbarConnectivityEffect extends OfferBuyEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}
