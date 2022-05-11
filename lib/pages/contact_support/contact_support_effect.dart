import 'package:localdaily/view_model.dart';

abstract class ContactSupportEffect extends Effect {}

class CreateContactSupportEffect extends ContactSupportEffect {}

class ShowSnackbarConnectivityEffect extends ContactSupportEffect {
  final String message;
  ShowSnackbarConnectivityEffect(this.message);
}

class ShowSnackbarSuccesEffect extends ContactSupportEffect {
  ShowSnackbarSuccesEffect();
}

class ShowSnackbarErrorEffect extends ContactSupportEffect {
  final String message;
  ShowSnackbarErrorEffect(this.message);
}
