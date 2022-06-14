import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/create_offers/transaction/body_createtransaction.dart';
import 'package:localdaily/services/models/create_offers/transaction/entity_transaction.dart';
import 'package:localdaily/services/models/detail_offer/result_update_status.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:provider/provider.dart';

class OfferModule {
  // SE CRAE UNA OFERTA DE COMPRA O VENTA
  static Future<void> createOffer(
    BuildContext context,
    DataUserProvider userProvider,
    Map<String, String>? params, {
    bool isBuy = false,
  }) async {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    final token = dataUserProvider.getTokenLogin;
    await ServiceInteractor()
        .createOffer(userProvider.getBodyOffer!, 'Bearer ${token!.token}')
        .then((ResponseData<ResultCreateOffer> response) async {
      if (response.isSuccess) {
        // Se crea la transacción en BD
        if (!isBuy && params != null) {
          await _createTransaction('Creacion de oferta LOCALDAILY', params,
              response.result!.id, context);
        }
        LdRouter().pop(LdRouter().navigatorKey.currentContext!);
        LdSnackbar.buildSuccessSnackbar(
          context,
          isBuy
              ? 'Se publicó exitosamente tu oferta de compra'
              : 'Se creó exitosamente tu oferta de venta, espera que sea aprobada',
        );
        LdRouter().goHome(LdRouter().navigatorKey.currentContext!);
        // Se limpia el objeto de oferta.
        userProvider.setBodyOffer(null);
      } else {
        // Se limpia el objeto de oferta.
        userProvider.setBodyOffer(null);
        LdSnackbar.buildErrorSnackbar(
          context,
          'Ocurrió un inconveniente, intenta más tarde',
        );
      }
    }).catchError((err) {
      print('Offer Error As: ${err}');
      // Se limpia el objeto de oferta.
      userProvider.setBodyOffer(null);
      LdRouter().pop(LdRouter().navigatorKey.currentContext!);
      LdSnackbar.buildErrorSnackbar(
        context,
        'Ocurrió un inconveniente, intenta más tarde',
      );
    });
  }

  // SE CREA UNA TRANSACCIÓN, RELACIONADA A UNA OFERTA DE VENTA
  static Future<void> _createTransaction(
    String message,
    Map<String, String> params,
    String adId,
    BuildContext context,
  ) async {
    // Se crea la transacción en BD
    final BodyCreateTransaction body = BodyCreateTransaction(
      entity: EntityTransaction(
        message: message,
        hash: params['trx']!,
        advertisementId: adId,
      ),
      strJsonMovements: json.encode(<Map<String, dynamic>>[
        <String, dynamic>{
          'amount': params['value']!,
          'address': params['from']!,
          'indicativeMovement': '0',
        },
        <String, dynamic>{
          'amount': params['value']!,
          'address': params['to']!,
          'indicativeMovement': '1',
        },
      ]),
    );
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    final token = dataUserProvider.getTokenLogin;
    ServiceInteractor()
        .createTransaction(body, 'Bearer ${token!.token}')
        .catchError((err) {
      print('ERROR CREATE TRANSACTION: $err');
      LdRouter().pop(LdRouter().navigatorKey.currentContext!);
    });
  }

  static Future<void> reserveoffer(
    BuildContext context,
    DataUserProvider userProvider,
    Map<String, String> params,
  ) async {
    // Se crea una transacción correspondiente a la reserva
    _createTransaction('Reserva de oferta LOCALDAILY', params,
        userProvider.getBodyUpdateStatus!.idAdvertisement, context);

    // Se actualiza la información de los bancos de la publicación
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    final token = dataUserProvider.getTokenLogin;
    ServiceInteractor()
        .addPayAccount(
            userProvider.getBodyAddPayAccount!, 'Bearer ${token!.token}')
        .then((ResponseData<dynamic> response) {
      if (response.isSuccess) {
        // Se actualiza el estado de la publicacion a en proceso
        final DataUserProvider dataUserProvider =
            context.read<DataUserProvider>();

        final token = dataUserProvider.getTokenLogin;
        ServiceInteractor()
            .reserveOffer(
                userProvider.getBodyUpdateStatus!, 'Bearer ${token!.token}')
            .then((ResponseData<ResultUpdateStatus> response) {
          if (response.isSuccess) {
            LdSnackbar.buildSuccessSnackbar(
              context,
              'Se reservó exitosamente la oferta de venta, espera que tu transacción sea aprobada',
            );
            LdRouter().goHome(LdRouter().navigatorKey.currentContext!);
            userProvider.setBodyUpdateStatus(null);
          } else {
            LdSnackbar.buildErrorSnackbar(
              context,
              'No fue posible separar la oferta, intenta más tarde',
            );
            print('Reserve Error As: ${response.error?.message}');
            userProvider.setBodyUpdateStatus(null);
          }
        }).catchError((err) {
          LdSnackbar.buildErrorSnackbar(
            context,
            'No fue posible separar la oferta, intenta más tarde',
          );
          print('Reserve Error As: ${err}');
          userProvider.setBodyUpdateStatus(null);
        });
        userProvider.setBodyAddPayAccount(null);
      } else {
        print('Add Pay Account Error As: ${response.error?.message}');
        LdSnackbar.buildErrorSnackbar(
          context,
          'No fue posible separar la oferta, intenta más tarde',
        );
        userProvider.setBodyAddPayAccount(null);
      }
    }).catchError((error) {
      LdSnackbar.buildErrorSnackbar(
        context,
        'No fue posible separar la oferta, intenta más tarde',
      );
      userProvider.setBodyAddPayAccount(null);
      print('Add Pay Account Error As: ${error}');
    });
  }
}
