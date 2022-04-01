import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/create_offers/transaction/body_createtransaction.dart';
import 'package:localdaily/services/models/create_offers/transaction/entity_transaction.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/utils/ld_snackbar.dart';

class OfferModule {
  static Future<void> createOffer(
    BuildContext context,
    DataUserProvider userProvider,
    Map<String, String> params,
  ) async {
    await ServiceInteractor()
        .createOffer(userProvider.getBodyOffer!)
        .then((ResponseData<ResultCreateOffer> response) async {
      if (response.isSuccess) {
        userProvider.setBodyOffer(null);
        // Se crea la transacción en BD
        await _createTransaction(
          params,
          response.result!.id,
          userProvider.getBodyOffer!.entity.valueToSell,
        );
        LdRouter().pop(LdRouter().navigatorKey.currentContext!);
        LdSnackbar.buildSuccessSnackbar(
          context,
          'Se ha creado tu publicación exitosamente, espera que sea aprobada',
          2,
        );
        LdRouter().goHome(LdRouter().navigatorKey.currentContext!);
      } else {
        LdSnackbar.buildErrorSnackbar(
          context,
          'Ocurrió un inconveniente, intenta más tarde',
        );
      }
    }).catchError((err) {
      print('Offer Error As: ${err}');
      LdRouter().pop(LdRouter().navigatorKey.currentContext!);
    });
  }

  static Future<void> _createTransaction(
      Map<String, String> params, String adId, String valueToSell) async {
    // Se crea la transacción en BD
    final BodyCreateTransaction body = BodyCreateTransaction(
      entity: EntityTransaction(
        message: 'Creacion de oferta LOCALDAILY',
        hash: params['trx']!,
        advertisementId: adId,
      ),
      strJsonMovements: json.encode(<Map<String, dynamic>>[
        <String, dynamic>{
          'amount': valueToSell,
          'address': params['from']!,
          'indicativeMovement': '0',
        },
        <String, dynamic>{
          'amount': valueToSell,
          'address': params['to']!,
          'indicativeMovement': '1',
        },
      ]),
    );
    ServiceInteractor().createTransaction(body).catchError((err) {
      print('ERROR CREATE TRANSACTION: $err');
      LdRouter().pop(LdRouter().navigatorKey.currentContext!);
    });
  }
}
