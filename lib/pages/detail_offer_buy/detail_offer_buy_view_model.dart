import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hex/hex.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
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

class DetailOfferBuyViewModel extends ViewModel<DetailOfferBuyStatus> {
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
    status = status.copyWith( dateOfExpire: difference.toString());
  }

//Validacion de campos validator
  String? validatorNotEmpty(String? valueText) {
    if (valueText == null || valueText.isEmpty) {
      return '* Secreto necesario';
    }
    return null;
  }

  Future<ResultDataUser?> getUserOfPost(String idUser) async {
    _interactor
        .getUserById(idUser)
        .then((ResponseData<ResultDataUser> response) {
      if (response.isSuccess) {
        print('Exito, obteniendo Usuario de Publicacion!!');
        status = status.copyWith(isLoading: false);
        return response.result;
      }
    }).catchError((err) {
      status = status.copyWith(
        isError: true,
      );
      print('Create SmartContract, Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
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

    // '${convertWorkKeccak('${wordSecretBuyer}buyercancel')},${convertWorkKeccak('${wordSecretBuyer}buyercancel')}'
    final ResultDataUser? userOfPost = await getUserOfPost(
      item.advertisement.idUserPublish,
    );
    final SmartContract smartContract = SmartContract(
      token: 'token',
      amount: item.advertisement.valueToSell,
      addressSeller: userOfPost!.addressWallet,
      addressBuyer: userCurrent.addressWallet,
      // doubleHashedSecretsOfSeller: '',//adquiriendo oferta de venta
      doubleHashedSecretsOfBuyer:
          '${convertWorkKeccak('${wordSecretBuyer}buyercancel')},${convertWorkKeccak('${wordSecretBuyer}buyeraprove')}',
      doubleHashedSecretsOfArbitrator:
          '3b00ba3bf87f129f4e62ec8ccc90f5fcd123d3b23e9925d1ce50b39e8ff71696,ac94cc5b67ad5826db279477174d683d15633819a4047611645356b6210cc716',
      doubleHashedSecretsOfSeller: '',
      // mandar Vacio el de seller
      salt: '',
    );
    final Advertisement advertisement = Advertisement(
      idAdvertisement: item.advertisement.id,
      idUserInteraction: userCurrent.id,
      statusOrigin: 0,
      statusDestiny: 1,
      successfulTransaction: true,
    );
    final BodyCreateSmartContract bodyCreateSmartContract =
        BodyCreateSmartContract(
      smartContract: smartContract,
      advertisement: advertisement,
    );

    print('Listo para el smart contrat');

    _interactor
        .createSmartContract(bodyCreateSmartContract)
        .then((ResponseData<ResultCreateSmartContract> response) {
      print('Create SmartContract Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('SmartContract Creado EXITOSAMENTE!!');

        // _route.goHome(context);
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
