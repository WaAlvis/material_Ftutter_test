import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings_update/settings_status.dart';
import 'package:localdaily/pages/settings_update/settings_update_effect.dart';
import 'package:localdaily/pages/settings_update/ui/settings_update_view.dart';
import 'package:localdaily/providers/data_user_provider.dart';

import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/token_login.dart';
import 'package:localdaily/services/models/response_data.dart';
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

    final ResultDataUser newDataUser = ResultDataUser(
      id: dataUser.id,
      nickName: newNickName,
      firstName: dataUser.firstName,
      secondName: dataUser.secondName,
      firstLastName: dataUser.firstLastName,
      secondLastName: dataUser.secondLastName,
      dateBirth: dataUser.dateBirth,
      email: dataUser.email,
      phone: dataUser.phone,
      userTypeId: dataUser.userTypeId,
      //TODO psw 12345678
      password:
          'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f',
      isActive: dataUser.isActive,
      addressWallet: dataUser.addressWallet,
      dateTimeCreate: dataUser.dateTimeCreate,
      rateSeller: dataUser.rateSeller,
      rateBuyer: dataUser.rateBuyer,
      isCorporative: dataUser.isCorporative,
      indicative: dataUser.indicative,
    );
    final TokenLogin token = dataUserProvider.getTokenLogin!;
    _interactor
        .updateDataUser(newDataUser, 'Bearer ${token.token}')
        .then((ResponseData<ResultDataUser> response) {
      if (response.isSuccess) {
        dataUserProvider.setDataUserLogged(
          response.result,
        );
        Navigator.pop(context);
      } else {
        // addEffect(ShowErrorSnackbar('No Actualizado'));

      }

      status = status.copyWith(isLoading: false);
    }).catchError((dynamic err) {
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
