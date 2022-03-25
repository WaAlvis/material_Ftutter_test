import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings/ui/settings_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'change_password_status.dart';

class ChangePasswordViewModel extends ViewModel<ChangePasswordStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  ChangePasswordViewModel(
    this._route,
    this._interactor,
  ) {
    status = ChangePasswordStatus(
      isLoading: true,
      isError: false,
      currentLanguage: Language.spanish,
    );
  }

  Future<void> onInit() async {}

  void goBack(BuildContext context) {
    _route.pop(context);
  }


}
