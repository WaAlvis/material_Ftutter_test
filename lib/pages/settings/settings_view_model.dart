import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings/settings_effect.dart';
import 'package:localdaily/pages/settings/ui/settings_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'settings_status.dart';

class SettingsViewModel
    extends EffectsViewModel<SettingsStatus, SettingEffect> {
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

  void goChangePsw(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goChangePsw(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goDirectionWallet(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        // _route.goDitectionWallet(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }
}
