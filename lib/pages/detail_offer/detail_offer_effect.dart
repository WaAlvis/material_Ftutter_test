import 'package:localdaily/view_model.dart';

abstract class DetailOfferEffect extends Effect {}

class ValidateOfferEffect extends DetailOfferEffect {}

class ShowSnackbarConnectivityEffect extends DetailOfferEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}
