import 'package:localdaily/view_model.dart';

abstract class OfferSaleEffect extends Effect {}

class ValidateOfferEffect extends OfferSaleEffect {}

class ShowSnackbarConnectivityEffect extends OfferSaleEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}
