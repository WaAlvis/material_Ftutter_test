import 'package:localdaily/view_model.dart';

abstract class ProfileSellerEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends ProfileSellerEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}

class ShowErrorSnackbar extends ProfileSellerEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}
