import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings_update/settings_status.dart';
import 'package:localdaily/pages/settings_update/settings_update_effect.dart';
import 'package:localdaily/pages/settings_update/ui/settings_update_view.dart';

import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

// import 'settings_status.dart';

class SettingsUpdateViewModel
    extends EffectsViewModel<SettingsUpdateStatus, SettingsUpdateEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  SettingsUpdateViewModel(
    this._route,
    this._interactor,
  ) {
    status = SettingsUpdateStatus(
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
