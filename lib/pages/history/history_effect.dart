import 'package:localdaily/pages/detail_offer/detail_offer_effect.dart';
import 'package:localdaily/view_model.dart';

abstract class HistoryEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends HistoryEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}


class ShowErrorSnackbar extends HistoryEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}
