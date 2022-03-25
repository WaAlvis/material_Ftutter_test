import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hex/hex.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_offer_buy/detail_offer_buy_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/detail_offer/advertisement.dart';
import 'package:localdaily/services/models/detail_offer/body_create_smart_contract.dart';
import 'package:localdaily/services/models/detail_offer/result_create_smart_contract.dart';
import 'package:localdaily/services/models/detail_offer/smart_contract.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:sha3/sha3.dart';

import 'detail_offer_buy_status.dart';

class DetailOfferBuyViewModel
    extends EffectsViewModel<DetailOfferBuyStatus, DetailOfferBuyEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  late Data item;

  DetailOfferBuyViewModel(this._route, this._interactor, this.item) {
    status = DetailOfferBuyStatus(
      isLoading: false,
      isError: true,
      item: item,
      dateOfExpire: '',
    );
  }

  Future<void> onInit(BuildContext context) async {
    status = status.copyWith(item: item);
    daysForExpire(item.advertisement.expiredDate as DateTime);
  }

  void daysForExpire(DateTime date) {
    final DateTime birthday = DateTime(date.year, date.month, date.day);
    final DateTime date2 = DateTime.now();
    final int difference = date2.difference(birthday).inDays;
    status = status.copyWith(dateOfExpire: difference.toString());
  }

//Validacion de campos validator
  String? validatorNotEmpty(String? valueText) {
    if (valueText == null || valueText.isEmpty) {
      return '* Secreto necesario';
    }
    return null;
  }

  /*  Future<ResultDataUser?> getUserOfPost(String idUser) async {
    ResultDataUser? user;
    await _interactor
        .getUserById(idUser)
        .then((ResponseData<ResultDataUser> response) {
      if (response.isSuccess) {
        print('Exito, obteniendo Usuario de Publicacion!!');
        status = status.copyWith(isLoading: false);
        print(response.result?.toJson());
        user = response.result;
      }
    }).catchError((err) {
      status = status.copyWith(
        isError: true,
      );
      print('Create SmartContract, Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
    return user;
  } */

  Future<void> onClickReserveDly() async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      addEffect(ValidateOfferEffect());
    } else {
      //addEffect(ShowSnackbarConnectivityEffect(_i18n.noConnection));
    }
  }

  Future<void> reservationPaymentForDly(
    BuildContext context, {
    required String wordSecretBuyer,
    required Data item,
    required ResultDataUser userCurrent,
  }) async {
    status = status.copyWith(isLoading: true);

    String convertWorkKeccak(String word) {
      final SHA3 k1 = SHA3(256, KECCAK_PADDING, 256);
      k1.update(utf8.encode(word));
      final List<int> hash1 = k1.digest();
      return HEX.encode(hash1);
    }

    final SmartContract smartContract = SmartContract(
      amount: item.advertisement.valueToSell,
      addressSeller: item.user.address,
      addressBuyer: userCurrent.addressWallet,
      doubleHashedSecretsOfBuyer:
          '${convertWorkKeccak('${wordSecretBuyer}buyercancel')},${convertWorkKeccak('${wordSecretBuyer}buyeraprove')}',
      doubleHashedSecretsOfArbitrator: '',
      doubleHashedSecretsOfSeller: '',
      salt: '',
    );
    final Advertisement advertisement = Advertisement(
      idAdvertisement: item.advertisement.id,
      idUserInteraction: userCurrent.id,
      statusOrigin: 0,
      statusDestiny: 1,
      successfulTransaction: true,
    );

    // Body requerido para la consulta.
    final BodyCreateSmartContract bodyCreateSmartContract =
        BodyCreateSmartContract(
      smartContract: smartContract,
      advertisement: advertisement,
      typeAdvertisementInfo: 0,
    );

    print('Listo para el smart contrat');

    _interactor
        .createSmartContract(bodyCreateSmartContract)
        .then((ResponseData<ResultCreateSmartContract> response) {
      if (response.isSuccess) {
        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
        print('no se pudo realizar la oferta ve venta!');
      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      print('Offera Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
  }
}
