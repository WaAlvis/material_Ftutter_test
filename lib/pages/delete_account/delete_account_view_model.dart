import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/delete_account/delete_account_effect.dart';
import 'package:localdaily/pages/info/ui/info_view.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';

import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:provider/provider.dart';

import 'delete_account_status.dart';

class DeleteAccountViewModel
    extends EffectsViewModel<DeleteAccountStatus, DeleteAccountEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;
  DeleteAccountViewModel(
    this._route,
    this._interactor,
  ) {
    status = DeleteAccountStatus(
      isLoading: false, isCurrentPswFieldEmpty: false,hidePass: true
    );
  }

  Future<void> onInit() async {}

  void goBack(BuildContext context) {
    _route.pop(context);
  }
// Todo implementar Servicio eliminar cuenta
  void deleteAccount(
    BuildContext context,
    DataUserProvider dataUserProvider,
    String psw,
    // String newPsw,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        deleteAccountService(context,dataUserProvider, psw);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  String? validatorPswNotEmpty(String email) {
    {
      if (email == null || email.isEmpty) {
        return '* La Contraseña actual es necesaria';
      }
      if (email.length < 8) {
        return '* Minimo 8 caracteres';
      }
      return null;
    }
  }

  void goPageSuccessChange(
    BuildContext context,
  ) {
    final InfoViewArguments info = InfoViewArguments(
      title: 'Felicitaciones',
      imageType: ImageType.success,
      description: 'Cambiaste tu contraseña de acceso a LocalDaily',
      actionCaption: 'Finalizar',
      onAction: () => _route.popTwo(context),
    );
    _route.goInfoView(context, info);
  }

  Digest encryptionPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }

  void hidePsw() => status = status.copyWith(
    hidePass: !status.hidePass,
  );
  void closeDialog(BuildContext context) {
    _route.pop(context);
  }

  void deleteAccountCloseDialog(BuildContext context) {
    _route.pop(context);

    final DataUserProvider dataUserProvider =
    context.read<DataUserProvider>();
    dataUserProvider.logoutClear();
    _route.goLoginForLogout(context);

  }
  // **para hacer el adecuado Logout por eliminacion de cuenta
  // void logoutUser(BuildContext context, DataUserProvider userProvider) {
  //   LdConnection.validateConnection().then((bool isConnectionValid) {
  //     if (isConnectionValid) {
  //       status = status.copyWith(resultDataUser: null);
  //       userProvider.logoutClear();
  //       _route.goLoginForLogout(context);
  //     } else {
  //       addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
  //     }
  //   });
  // }

  Future<void> deleteAccountService(
    BuildContext context,
    DataUserProvider dataUserProvider,
    String psw,
  ) async {

  addEffect(DialogConfirmDeleteAccount());
  // logoutUser(context, user); Todo: implementar adecuadaente el Logount
  // status = status.copyWith(isLoading: true);
  //   final String oldSha256Psw = encryptionPass(oldPsw).toString();
  //   final String newSha256Psw = encryptionPass(newPsw).toString();
  //
  //   final BodyChangePsw bodyChangePsw = BodyChangePsw(
  //     clientId: 'f160e3d8-aca1-4c5b-a7df-c07a858013cd',
  //     userId: idUser,
  //     password: oldSha256Psw,
  //     newPassword: newSha256Psw,
  //   );
  //   final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
  //
  //   final token = dataUserProvider.getTokenLogin;
  //   _interactor
  //       .changePsw(bodyChangePsw, 'Bearer ${token!.token}')
  //       .then((ResponseData<ResultChangePsw> response) {
  //     if (response.isSuccess) {
  //       addEffect(ShowSuccessSnackbar('Contraseña actualizada'));
  //       goPageSuccessChange(
  //         context,
  //       );
  //     } else {
  //       addEffect(ShowWarningSnackbar('Error en la actualización'));
  //     }
  //     status = status.copyWith(isLoading: false);
  //   }).catchError((Object err) {
  //     addEffect(ShowErrorSnackbar('Error en el servicio**'));
  //     status = status.copyWith(isLoading: false);
  //   });
  }



}
