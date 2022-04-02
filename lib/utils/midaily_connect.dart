import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/local_storage_service.dart';
import 'package:localdaily/services/models/users/body_updateaddress.dart';
import 'package:localdaily/services/modules/offer_module.dart';
import 'package:localdaily/utils/crypto_utils.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MiDailyConnect {
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static Future<void> createConnection(
    BuildContext context,
    DailyConnectType type,
    String? amount,
  ) async {
    final DataUserProvider userProvider = context.read<DataUserProvider>();
    final String _walletConnectCode = _getRandomString(7);
    final String _from = userProvider.getAddress ?? '';

    // Se valida el monto con el balance para solicitar creacion
    if (amount != null || amount != '') {
      if (double.parse(amount!) > await CryptoUtils().getBalance(_from)) {
        LdSnackbar.buildErrorSnackbar(
          context,
          'No hay fondos suficientes para realizar la operación',
        );
        return;
      }
    }

    userProvider.setMiDailyConnectCode(_walletConnectCode);
    String _url = '';

    switch (type) {
      case DailyConnectType.walletAddress:
        //_url =
        //    'exp://192.168.1.46:19000/--/walletaddress?scheme=localdaily&path=$_walletConnectCode';
        _url =
            'exp://127.0.0.1:19000/--/walletaddress?scheme=localdaily&path=$_walletConnectCode';
        break;
      case DailyConnectType.transaction:
        //_url =
        //    'exp://192.168.1.46:19000/--/sendtransaction?scheme=localdaily&path=$_walletConnectCode&from=$_from&to=0x8651A084e57Bfc93F901289767E4733Ee08cEe6B&value=$amount';
        _url =
            'exp://127.0.0.1:19000/--/sendtransaction?scheme=localdaily&path=$_walletConnectCode&from=$_from&to=0x8651A084e57Bfc93F901289767E4733Ee08cEe6B&value=$amount';
        break;
      default:
    }

    if (await canLaunch(_url)) {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      final String encoded = stringToBase64.encode(_url);
      print(encoded);
      await launch(_url, headers: <String, String>{});
    } else {
      //TODO: Aplicacion no esta instalada, abrir la tienda dependiendo SO.
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

    final String host = uri.host;

    // Validar que el código generado sea el mismo al que recibe como respuesta
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

      String err =
          'Ocurrió un inconveniente con la petición, intentalo más tarde';
      if (errCode == 'UNAUTHORIZED') {
        err = 'La solicitud fue rechazada, intentalo más tarde';
      } else if (errCode == 'TRXFAILED') {
        err = 'La transacción no pudo ser procesada, intentalo más tarde';
      } else if (errCode == 'INSUFICIENTFUNDS') {
        err = 'No hay fondos suficientes para realizar la operación';
      } else if (errCode == 'INVALIDFROM') {
        err =
            'La dirección actual no corresponde a la dirección de la wallet MiDaily';
      } else if (errCode == 'OTP') {
        err =
            'Ocurrió un inconveniente con la clave dinámica, intentalo más tarde';
      }

      LdSnackbar.buildErrorSnackbar(
        context,
        err,
      );
      return;
    }

    switch (path) {
      case 'walletaddress':
        final String? address = uri.queryParameters['result'];
        await _saveAddress(
          context,
          address,
          userProvider.getDataUserLogged!.email,
          userProvider,
        );
        break;
      case 'sendtransaction':
        await _sendTransaction(context, userProvider, uri.queryParameters);
        break;
      default:
    }
  }

  // Guarda address retornada de Midaily en localStorage con email como key
  Future<void> _saveAddress(
    BuildContext context,
    String? address,
    String email,
    DataUserProvider userProvider,
  ) async {
    if (address == null || address.isEmpty) {
      LdSnackbar.buildErrorSnackbar(
        context,
        'Ocurrió un inconveniente, intenta más tarde',
      );
      return;
    }

    // Guardar en bd el address
    ServiceInteractor()
        .putUpdateAddress(
      BodyUpdateAddress(
        idUser: userProvider.getDataUserLogged?.id ?? '',
        addressWallet: address,
      ),
    )
        .then((value) async {
      if (value.isSuccess) {
        // Guardar localmente el address
        final LocalStorageService _localStorage =
            locator<LocalStorageService>();
        _localStorage.getPreferences()?.setString(email, address);
        userProvider.setAddress(address);
        LdSnackbar.buildSuccessSnackbar(
          context,
          'Se guardó tu dirección de wallet MiDaily',
          2,
        );
      } else {
        LdSnackbar.buildErrorSnackbar(
          context,
          'Se guardó tu dirección de wallet MiDaily',
        );
      }
    });

    return;
  }

  // Se conecta a MiDaily para realizar una transacción
  Future<void> _sendTransaction(
    BuildContext context,
    DataUserProvider userProvider,
    Map<String, String> params,
  ) async {
    if (params['trx'] == null ||
        params['to'] == null ||
        params['from'] == null) {
      LdSnackbar.buildErrorSnackbar(
        context,
        'Ocurrió un inconveniente, intenta más tarde',
      );
      return;
    }

    LdDialog.buildLoadingDialog(context);

    if (userProvider.getBodyOffer == null) {
      LdRouter().pop(LdRouter().navigatorKey.currentContext!);
      LdSnackbar.buildErrorSnackbar(
        context,
        'Ocurrió un inconveniente, intenta más tarde',
      );
      return;
    }

    // Se crea la publicación y despúes de eso la transacción en BD
    OfferModule.createOffer(context, userProvider, params);
  }

  static Future<void> removeAddress(
    BuildContext context,
    String email,
    DataUserProvider userProvider,
  ) async {
    // Eliminar localmente el address
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
