import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings/ui/settings_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'settings_status.dart';

class SettingsViewModel extends ViewModel<SettingsStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  SettingsViewModel(
    this._route,
    this._interactor,
  ) {
    status = SettingsStatus(
      isLoading: true,
      isError: false,
      currentLanguage: Language.spanish,
    );
  }

  Future<void> onInit() async {}

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  void changeLanguage(Language? value) {
    status = status.copyWith(currentLanguage: value);
  }
}
