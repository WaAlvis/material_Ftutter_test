import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings_update/settings_status.dart';
import 'package:localdaily/pages/settings_update/settings_update_effect.dart';
import 'package:localdaily/pages/settings_update/ui/settings_update_view.dart';
import 'package:localdaily/providers/data_user_provider.dart';

import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/change_psw/result_change_psw.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/services/models/update_data_user/body_new_data_user.dart';
import 'package:localdaily/services/models/update_data_user/result_change_data_user.dart';
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
      isNickNameFieldEmpty: true,
    );
  }

  Future<void> onInit() async {}

  String? validatorNickName(String? str) {
    if (str == null || str.isEmpty) {
      return '* Campo necesario';
    }
    if (str.length < 8 || str.length > 35) {
      return '* Minímo 8 y máximo 35 caracteres';
    }
    return null;
  }

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  void changeDataUser(
    BuildContext context,
    String newNickName,
    DataUserProvider dataUserProvider,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        changeNickNameService(context, newNickName, dataUserProvider);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> changeNickNameService(
    BuildContext context,
    String newNickName,
    DataUserProvider dataUserProvider,
  ) async {
    status = status.copyWith(isLoading: true);
    final ResultDataUser dataUser = dataUserProvider.getDataUserLogged!;

    final BodyNewDataUser bodyNewNick = BodyNewDataUser(id: dataUser.id, newValue: newNickName);
    final TokenLogin token = dataUserProvider.getTokenLogin!;
    _interactor
        .updateDataUser(bodyNewNick, 'Bearer ${token.token}')
        .then((ResponseData<ResultChangeDataUser> response) {
      if (response.isSuccess) {
        dataUserProvider.setNickName(
            newNickName,
        );
        Navigator.pop(context);
      } else {
        // addEffect(ShowErrorSnackbar('No Actualizado'));

      }

      status = status.copyWith(isLoading: false);
    }).catchError((dynamic err) {
      print('@@@ $err');
      // addEffect(ShowErrorSnackbar('Error en el servicio**'));
      status = status.copyWith(isLoading: false);
    });
  }

  void changeNickName(String nickName) =>
      status = status.copyWith(isNickNameFieldEmpty: nickName.isEmpty);

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
