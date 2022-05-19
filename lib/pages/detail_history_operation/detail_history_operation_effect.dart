import 'package:localdaily/view_model.dart';

abstract class DetailHistoryOperationEffect extends Effect {}

class ShowSnackbarConnectivityEffect extends DetailHistoryOperationEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}


class ShowErrorSnackbar extends DetailHistoryOperationEffect {
  final String message;

  ShowErrorSnackbar(this.message);
}
