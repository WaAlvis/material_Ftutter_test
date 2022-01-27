import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offerts/offert/body_offert.dart';
import 'package:localdaily/services/models/create_offerts/offert/entity_offer.dart';
import 'package:localdaily/services/models/create_offerts/offert/result_create_offert.dart';
import 'package:localdaily/services/models/detail_offer/advertisement.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/data.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:sha3/sha3.dart';

import 'detail_offer_buy_status.dart';

class DetailOfferBuyViewModel extends ViewModel<DetailOfferBuyStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  DetailOfferBuyViewModel(
    this._route,
    this._interactor,
  ) {
    status = DetailOfferBuyStatus(
      isLoading: false,
      isError: true,
    );
  }

  Future<void> onInit(BuildContext context) async {
    // getBank(context);
  }

//Validacion de campos validator
  String? validatorNotEmpty(String? valueText) {
    if (valueText == null || valueText.isEmpty) {
      return '* Secreto necesario';
    }
    return null;
  }

  Future<void> reservationPaymentForDly(
    BuildContext context, {
    required String wordSecretBuyer,
    required Data item,
  }) async {
    status = status.copyWith(isLoading: true);

    String convertWorkKeccak(String word) {
      final SHA3 k1 = SHA3(256, KECCAK_PADDING, 256);
      final SHA3 k2 = SHA3(256, KECCAK_PADDING, 256);
      k1.update(utf8.encode(word));
      final List<int> hash1 = k1.digest();
      k2.update(hash1);
      final List<int> hash2 = k2.digest();
      return HEX.encode(hash2);
    }

    final SmartContract smartContract = SmartContract(
        token: 'token',
        amount: item.advertisement.valueToSell,
        addressSeller: item.advertisement,
        addressBuyer: addressBuyer,
        doubleHashedSecretsOfBuyer: doubleHashedSecretsOfBuyer,
        doubleHashedSecretsOfArbitrator: 'secreto1,secreto1.2',
        // salt: salt
    );

    final BodyOffert bodyOffert = BodyOffert(
        entity: entity,
        daysOfExpired: 7,
        strJsonAdvertisementBanks:
            '[{\"bankId\": \"${bankId}\",\"accountNumber\": \"${accountNumCtrl.text}\",\"accountTypeId\": \"${accountTypeId}\",\"documentNumber\": \"${docNumCtrl.text}\",\"documentTypeID\" : \"${docType}\",\"titularUserName\": \"${nameTitularAccountCtrl.text}\"},]');
// "[{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\": \"555555555\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"123456789\",\"documentTypeID\" : \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"titularUserName\": \"Roger Gutierrez\"},{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\":\"101010101\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentTypeID\" : \"eb2e8229-13ee-4282-b053-32e7b444ea10\",\"documentNumber\": \"987654321\",\"titularUserName\": \"Carmen Martinez\"}]"

    _interactor
        .createOffert(bodyOffert)
        .then((ResponseData<ResultCreateOffert> response) {
      print('Create Offert Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Oferta de venta creada EXITOSO!!');

        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
        print('no se pudo realizar la oferta ve venta!');
      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      print('Offerta Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
  }
}
