import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/local_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MiDailyConnect {
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static Future<void> createConnection(
    BuildContext context,
    DailyConnectType type,
  ) async {
    final DataUserProvider userProvider = context.read<DataUserProvider>();
    final String _walletConnectCode = _getRandomString(7);
    userProvider.setMiDailyConnectCode(_walletConnectCode);
    String _url = '';

    switch (type) {
      case DailyConnectType.walletAddress:
        _url =
            'midailyapp://walletaddress?scheme=localdaily&path=$_walletConnectCode';
        break;
      case DailyConnectType.transaction:
        _url =
            'midailyapp://transaction?scheme=localdaily&path=$_walletConnectCode';
        break;
      default:
    }

    print(_url);

    if (await canLaunch(_url)) {
      print('Abrir');
      await launch(_url, headers: <String, String>{});
    } else {
      print('TODO: Abrir tiendas');
      //TODO: Aplicacion no esta instalada, abrir la tienda dependiendo SO.
      if (Platform.isIOS) {
      } else {}
    }
  }

  // Listener para la conexión con MiDaily
  static void handleIncomingLinks(BuildContext context, Uri? uri) {
    print(uri);
    // Validar URL
    if (uri == null) return;

    // Validar usuario Loggeado
    final DataUserProvider userProvider = context.read<DataUserProvider>();
    if (userProvider.getDataUserLogged == null) return;

    // Validar que el código generado sea el mismo al que recibe como respuesta
    final String host = uri.host;
    if (userProvider.getMiDailyConnectCode == null ||
        host != userProvider.getMiDailyConnectCode) return;

    // Validar que el path o funcion no esta vacío
    final String? path = uri.queryParameters['path'];
    if (path == null || path.isEmpty) return;

    // Validar si la operación fue exitosa o no
    final bool? isSuccess = uri.queryParameters['isSuccess'] as bool?;
    if (isSuccess == null || !isSuccess) {
      // TODO: Mostrar retroalimentación del error
      final String? errCode = uri.queryParameters['error'];
      print(errCode);
      return;
    }

    switch (path) {
      case 'walletaddress':
        final String? address = uri.queryParameters['result'];
        _saveAddress(address, userProvider.getDataUserLogged!.email);
        break;
      case 'transaction':
        // TODO: Lògica para realizar trx
        break;
      default:
    }
  }

  // Guarda address retornada de Midaily en localStorage con email como key
  static void _saveAddress(String? address, String email) {
    if (address == null || address.isEmpty) return;
    final LocalStorageService _localStorage = locator<LocalStorageService>();
    _localStorage.getPreferences()?.setString(email, address);
    print('/// EMAIL GUARDADO ///');
    print(_localStorage.getPreferences()?.getString(email));
  }

  // Remueve address guardada de Midaily, desconecta con dailyconnect
  static Future<void> removeAddress(String email) async {
    final LocalStorageService _localStorage = locator<LocalStorageService>();
    await _localStorage.getPreferences()?.remove(email);
  }

  static String _getRandomString(int length) => String.fromCharCodes(
        Iterable<int>.generate(
          length,
          (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
        ),
      );
}
