import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/configure/local_storage_service.dart';
import 'package:localdaily/pages/login/login_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/response/result_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/utils/login/biometric_utils.dart';
import 'package:localdaily/view_model.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import 'login_status.dart';

class LoginViewModel extends EffectsViewModel<LoginStatus, LoginEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  late LocalStorageService _localStorage;

  LoginViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
    LocalStorageService? localStorage,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();
    _localStorage = localStorage ?? locator<LocalStorageService>();

    status = LoginStatus(
      isLoading: false,
      isError: false,
      hidePass: true,
      isEmailFieldEmpty: true,
      isPswFieldEmpty: true,
      isBio: false,
    );
  }

  void hidePassword() => status = status.copyWith(
        hidePass: !status.hidePass,
      );

  Future<void> onInit({
    bool validateNotification = false,
    required BuildContext context,
  }) async {
    final bool bio = await BiometricLoginUtils.canHandleBiometrics();
    status = status.copyWith(isBio: bio);
    final List<String> enableList =
        _localStorage.getPreferences()?.getStringList('biometric') ??
            <String>[];

    // print(' @@@@ ${status.isBio} ${enableList}');
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    if (enableList.isNotEmpty) {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      String? pss = await storage.read(key: 'bio-${enableList.last}');
      Map<String, String> allValues = await storage.readAll();
      // print('@@@ pass; $pss and user : ${enableList.last}');
      if (await BiometricLoginUtils.handleBiometricAuth()) {
        loginBiometric(context, enableList.last, pss!, dataUserProvider);
      }
    }
  }

  //Login
  void changeEmail(String email) =>
      status = status.copyWith(isEmailFieldEmpty: email.isEmpty);

  void changePsw(String psw) =>
      status = status.copyWith(isPswFieldEmpty: psw.isEmpty);

  //Register

  void goHomeForLogin(
    BuildContext context,
    TextEditingController userCtrl,
    TextEditingController passwordCtrl,
    DataUserProvider dataUserProvider,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        login(
          context,
          userCtrl.text,
          passwordCtrl.text,
          dataUserProvider,
        );
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goRegister(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goEmailRegister(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goRecoverPassword(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goRecoverPsw(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void closeDialog(BuildContext context) {
    _route.pop(context);
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
    DataUserProvider dataUserProvider,
  ) async {
    status = status.copyWith(isLoading: true);
    final String pass256 = encryptPass(password).toString();

    final BodyLogin bodyLogin = BodyLogin(
      identity: email,
      password: pass256,
      // password: '',
      signature:
          'T2CswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==',
      wearableId: 'd9b1289a-ae98-4e86-a145-ac046a8bd5be',
    );

    _interactor.postLogin(bodyLogin).then((ResponseData<ResultLogin> response) {
      if (response.isSuccess) {
        dataUserProvider.setTokenLogin(response.result!.tokenData);
        final String idUser = response.result!.user.id;
        final token = dataUserProvider.getTokenLogin;
        final List<String> enableList =
            _localStorage.getPreferences()?.getStringList('biometric') ??
                <String>[];
        const FlutterSecureStorage storage = FlutterSecureStorage();
        _interactor
            .getUserById(idUser, 'Bearer ${token!.token}')
            .then((ResponseData<ResultDataUser> response) {
          if (response.isSuccess) {
            dataUserProvider.setNickName(response.result!.nickName);
            dataUserProvider.setDataUserLogged(
              response.result,
            );
            if (status.isBio) {
              LdDialog.buildGenericAlertDialog(
                context,
                message:
                    'Puede agregar un inicio de sesion biometrico\n\n¿Deseas continuar?',
                btnText: 'Aceptar',
                onTap: () async {
                  if (await BiometricLoginUtils.handleBiometricAuth()) {
                    _route.goHome(context);
                    enableList.add(email);
                    _localStorage
                        .getPreferences()
                        ?.setStringList('biometric', enableList);
                    await storage.write(key: 'bio-$email', value: pass256);
                    Map<String, String> allValues = await storage.readAll();
                    // print('@@@ $allValues');
                    LdSnackbar.buildSuccessSnackbar(context,
                        '¡Perfecto! has habilitado tu inicio de sesión biométrico. Podrás utilizarlo de aquí en adelante cada que ingreses a LocalDLY.');
                  }
                },
                btnTextSecondary: 'Tal vez, después',
                onTapSecondary: () {
                  _route.goHome(context);
                },
              );
            } else {
              // print('@@@ No es posible usar biometricos');
              _route.goHome(context);
            }
          } else {
            addEffect(ShowErrorSnackbar('Error al obtener informacion'));
          }
          status = status.copyWith(isLoading: false);
        }).catchError((Object err) {
          addEffect(ShowErrorSnackbar('Error en el servicio**'));
          status = status.copyWith(isLoading: false);
        });
      } else {
        status = status.copyWith(isLoading: false);
        final String attemps = response.error!.info['attemps'] as String;
        if (int.parse(attemps) == 3) {
          final String timeLocked =
              response.error!.info['timeUnlock'] as String;
          status = status.copyWith(
            timeUnlockUser: _timeUnlockUser(timeLocked),
          );
          addEffect(DialogFailAttempsLogin());
          addEffect(ShowErrorSnackbar('Bloqueo temporal del Usuario'));

          return;
        }
        addEffect(ShowErrorSnackbar('Usuario o contraseña incorrectos'));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((dynamic err) {
      addEffect(ShowErrorSnackbar('Error en el servicio**'));
      status = status.copyWith(isLoading: false);
    });
  }

// Login biometrico
  Future<void> loginBiometric(
    BuildContext context,
    String email,
    String password,
    DataUserProvider dataUserProvider,
  ) async {
    status = status.copyWith(isLoading: true);
    // final String pass256 = encryptPass(password).toString();

    final BodyLogin bodyLogin = BodyLogin(
      identity: email,
      password: password,
      signature:
          'T2CswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==',
      wearableId: 'd9b1289a-ae98-4e86-a145-ac046a8bd5be',
    );

    _interactor.postLogin(bodyLogin).then((ResponseData<ResultLogin> response) {
      if (response.isSuccess) {
        dataUserProvider.setTokenLogin(response.result!.tokenData);
        final String idUser = response.result!.user.id;
        final token = dataUserProvider.getTokenLogin;
        final List<String> enableList =
            _localStorage.getPreferences()?.getStringList('biometric') ??
                <String>[];
        const FlutterSecureStorage storage = FlutterSecureStorage();
        _interactor
            .getUserById(idUser, 'Bearer ${token!.token}')
            .then((ResponseData<ResultDataUser> response) {
          if (response.isSuccess) {
            dataUserProvider.setNickName(response.result!.nickName);
            dataUserProvider.setDataUserLogged(
              response.result,
            );

            dataUserProvider.setNickName(response.result!.nickName);
            _route.goHome(context);
          } else {
            addEffect(ShowErrorSnackbar('Error al obtener informacion'));
          }
          status = status.copyWith(isLoading: false);
        }).catchError((Object err) {
          addEffect(ShowErrorSnackbar('Error en el servicio**'));
          status = status.copyWith(isLoading: false);
        });
      } else {
        status = status.copyWith(isLoading: false);
        final String attemps = response.error!.info['attemps'] as String;
        if (int.parse(attemps) == 3) {
          final String timeLocked =
              response.error!.info['timeUnlock'] as String;
          status = status.copyWith(
            timeUnlockUser: _timeUnlockUser(timeLocked),
          );
          addEffect(DialogFailAttempsLogin());
          addEffect(ShowErrorSnackbar('Bloqueo temporal del Usuario'));

          return;
        }
        addEffect(ShowErrorSnackbar('Usuario o contraseña incorrectos'));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((dynamic err) {
      addEffect(ShowErrorSnackbar('Error en el servicio**'));
      status = status.copyWith(isLoading: false);
    });
  }

  String _timeUnlockUser(String timeLock) {
    final int halfHour = (Duration.millisecondsPerHour * 0.5).toInt();
    final int timeLocked = int.parse(timeLock);
    final int unlockTime = halfHour + timeLocked;
    final DateTime dt = DateTime.fromMillisecondsSinceEpoch(unlockTime);
    final String d12TimeUnlock = DateFormat('hh:mm a').format(dt);
    return d12TimeUnlock;
  }

  Digest encryptPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }

  String? validatorEmail(String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo obligatorio';
      } else if (!isEmail(email)) {
        return '* Debe ser un correo';
      }
      return null;
    }
  }

  String? validatorPass(String? pass) {
    {
      if (pass == null || pass.isEmpty) {
        return '* Campo obligatorio';
      } else if (pass.length < 8) {
        return '* Contraseña incompleta';
      }
      return null;
    }
  }
}
