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
      isPasswordFieldEmpty: true,
      hasUpperLetter: false,
      hasMore8Chars: false,
      hasSpecialChar: false,
      hasLowerLetter: false,
      hasNumberChar: false,
      hidePass: true,

    );
  }

  Future<void> onInit() async {}

  void goBack(BuildContext context) {
    _route.pop(context);
  }

  void changePassword(String password) =>
      status = status.copyWith(isPasswordFieldEmpty: password.isEmpty);

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

  void hidePassword() => status = status.copyWith(
    hidePass: !status.hidePass,
  );

  String? validatorPasswords(String? psw, String? confirmPsw) {
    if (psw == null || psw.isEmpty) {
      return '* la contraseña es necesaria';
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

