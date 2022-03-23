import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';
import 'dart:math';

import 'detail_history_operation_status.dart';

class DetailHistoryOperationViewModel
    extends ViewModel<DetailHistoryOperation> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  DetailHistoryOperationViewModel(
    this._route,
    this._interactor,
  ) {
    status = DetailHistoryOperation(
      isLoading: true,
      isError: false,
    );
  }

  Future<void> onInit() async {

  }

  void goBack(BuildContext context) {
    _route.pop(context);
  }
}
