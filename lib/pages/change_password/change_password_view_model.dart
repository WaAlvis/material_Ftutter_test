import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/change_password/change_password_effect.dart';
import 'package:localdaily/pages/info/ui/info_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/change_psw/body_change_psw.dart';
import 'package:localdaily/services/models/change_psw/result_change_psw.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'change_password_status.dart';

class ChangePasswordViewModel
    extends EffectsViewModel<ChangePasswordStatus, ChangePswEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  ChangePasswordViewModel(
    this._route,
    this._interactor,
  ) {
    status = ChangePasswordStatus(
      isLoading: false,
      isError: false,
      isCurrentPswFieldEmpty: true,
      hasUpperLetter: false,
      hasMore8Chars: false,
      hasSpecialChar: false,
      hasLowerLetter: false,
      hasNumberChar: false,
      hidePass: true,
      isAgainNewPswFieldEmpty: true,
      isNewPswFieldEmpty: true,
    );
  }

  Future<void> onInit() async {}

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  void changeCurrentPsw(String password) =>
      status = status.copyWith(isCurrentPswFieldEmpty: password.isEmpty);

  void changeNewPsw(String password) =>
      status = status.copyWith(isNewPswFieldEmpty: password.isEmpty);

  void changeAgainNewPsw(String password) =>
      status = status.copyWith(isAgainNewPswFieldEmpty: password.isEmpty);

  bool isPasswordValid(String password, [int minLength = 7]) {
    final bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    final bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final bool hasMinLength = password.length > minLength;
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));

    status = status.copyWith(
      hasMore8Chars: hasMinLength,
      hasUpperLetter: hasUppercase,
      hasSpecialChar: hasSpecialCharacters,
      hasLowerLetter: hasLowercase,
      hasNumberChar: hasDigits,
    );
    return hasMinLength &
        hasUppercase &
        hasSpecialCharacters &
        hasLowercase &
        hasDigits;
  }

  void changePsw(
    BuildContext context,
    String idUser,
    String oldPsw,
    String newPsw,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        status = status.copyWith(isLoading: true);
        changePswService(context, idUser, oldPsw, newPsw);
        // goPageSuccessRecover(context, textTheme, email);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goPageSuccessChange(
    BuildContext context,
  ) {
    final InfoViewArguments info = InfoViewArguments(
      title: 'Felicitaciones',
      imageType: ImageType.success,
      description: 'Cambiaste tu contraseña de acceso a LocalDaily',
      actionCaption: 'Finalizar',
      onAction: () => _route.goSettings(context),
    );
    _route.goInfoView(context, info);
  }

  Digest encryptionPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }

  Future<void> changePswService(
    BuildContext context,
    String idUser,
    String oldPsw,
    String newPsw,
  ) async {
    status = status.copyWith(isLoading: true);
    final String oldSha256Psw = encryptionPass(oldPsw).toString();
    final String newSha256Psw = encryptionPass(newPsw).toString();

    final BodyChangePsw bodyChangePsw = BodyChangePsw(
      clientId: 'f160e3d8-aca1-4c5b-a7df-c07a858013cd',
      userId: idUser,
      password: oldSha256Psw,
      newPassword: newSha256Psw,
    );

    _interactor
        .changePsw(bodyChangePsw)
        .then((ResponseData<ResultChangePsw> response) {
      if (response.isSuccess) {
        addEffect(ShowSuccessSnackbar('Contraseña actualizada'));
        goPageSuccessChange(
          context,
        );
        status = status.copyWith(isLoading: false);
      } else {
        addEffect(ShowWarningSnackbar('Error en la actualizacion'));
        status = status.copyWith(isError: true, isLoading: false);
      }
    }).catchError((err) {
      status = status.copyWith(isError: true, isLoading: false);

      addEffect(ShowErrorSnackbar('Error en el servicio**'));
      print('NewPsw Error As: ${err}');
    });
  }

  void hidePassword() => status = status.copyWith(
        hidePass: !status.hidePass,
      );

  String? validatorCurrentPswNotEmpty(String? email) {
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

  String? validatorPasswords(String? psw, String? confirmPsw) {
    if (psw == null || psw.isEmpty) {
      return '* la nueva contraseña es necesaria';
    } else if (psw != confirmPsw) {
      return 'Las contraseñas no coinciden';
    }
    if (psw.length < 8 || confirmPsw!.length < 8) {
      return 'La contraseña debe incluir al menos 8 caracteres alfanuméricos';
    }
    if (!isPasswordValid(psw)) {
      return 'La contraseña no cumple los requerimientos';
    }
    return null;
  }
}
