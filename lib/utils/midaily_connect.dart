import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/local_storage_service.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MiDailyConnect {
  static const String _chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
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
            'exp://172.18.1.5:19000/--/walletaddress?scheme=localdaily&path=$_walletConnectCode';
        break;
      case DailyConnectType.transaction:
        _url =
            'exp://172.18.1.5:19000/--/walletaddress?scheme=localdaily&path=$_walletConnectCode';
        break;
      default:
    }

    if (await canLaunch(_url)) {
      await launch(_url, headers: <String, String>{});
    } else {
      //TODO: Aplicacion no esta instalada, abrir la tienda dependiendo SO.
      if (Platform.isIOS) {
      } else {}
    }
  }

  // Listener para la conexión con MiDaily
  Future<void> handleIncomingLinks(
    BuildContext context,
    Uri? uri,
  ) async {
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
    final String? isSuccess = uri.queryParameters['success'];
    if (isSuccess == null || isSuccess.isEmpty || isSuccess != 'true') {
      final String? errCode = uri.queryParameters['error'];
      print(errCode);
      // TODO: Mostrar error por cada tipo
      LdSnackbar.buildErrorSnackbar(
        context,
        'Ocurrió un inconveniente, intenta más tarde',
      );
      return;
    }

    switch (path) {
      case 'walletaddress':
        final String? address = uri.queryParameters['result'];
        if (await _saveAddress(
          address,
          userProvider.getDataUserLogged!.email,
          userProvider,
        )) {
          LdSnackbar.buildSuccessSnackbar(
            context,
            'Se guardó tu dirección de wallet MiDaily',
            2,
          );
        } else {
          LdSnackbar.buildErrorSnackbar(
            context,
            'Ocurrió un inconveniente, intenta más tarde',
          );
        }
        break;
      case 'transaction':
        // TODO: Lògica para realizar trx
        break;
      default:
    }
  }

  // Guarda address retornada de Midaily en localStorage con email como key
  static Future<bool> _saveAddress(
    String? address,
    String email,
    DataUserProvider userProvider,
  ) async {
    if (address == null || address.isEmpty) return false;
    final LocalStorageService _localStorage = locator<LocalStorageService>();
    await _localStorage.getPreferences()?.setString(email, address);
    userProvider.setAddress(address);
    return true;
  }

  // Remueve address guardada de Midaily, desconecta con dailyconnect
  static Future<void> removeAddress(
    BuildContext context,
    String email,
    DataUserProvider userProvider,
  ) async {
    final LocalStorageService _localStorage = locator<LocalStorageService>();
    await _localStorage.getPreferences()?.remove(email);
    userProvider.setAddress('');
  }

  static String _getRandomString(int length) => String.fromCharCodes(
        Iterable<int>.generate(
          length,
          (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
        ),
      );
}
