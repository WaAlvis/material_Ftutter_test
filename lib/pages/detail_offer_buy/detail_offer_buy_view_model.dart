import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hex/hex.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_offer_buy/detail_offer_buy_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/detail_offer/advertisement.dart';
import 'package:localdaily/services/models/detail_offer/body_create_smart_contract.dart';
import 'package:localdaily/services/models/detail_offer/result_create_smart_contract.dart';
import 'package:localdaily/services/models/detail_offer/smart_contract.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/pagination.dart';
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
      selectedDocType: null,
      selectedAccountType: null,
      selectedBank: null,
      listBanks: ResultGetBanks(
        data: <Bank>[],
        totalItems: 10,
        totalPages: 1,
      ),
      listDocsType: ResultGetDocsType(
        data: <DocType>[],
        totalItems: 10,
        totalPages: 1,
      ),
      listAccountType: ResultGetDocsType(
        data: <DocType>[
          DocType(
            id: 'd307fd7e-c76f-44b6-a8ff-768ad6421616',
            countryId: '17cccd6d-1675-485b-806b-5297063e6826',
            description: 'Corriente',
            isActive: true,
          ),
          DocType(
            id: 'c047a07c-2daf-48a7-ad49-ec447a93485b',
            countryId: '17cccd6d-1675-485b-806b-5297063e6826',
            description: 'Ahorros',
            isActive: true,
          ),
        ],
        totalItems: 10,
        totalPages: 1,
      ),
    );
  }

  Future<void> onInit(BuildContext context) async {
    status = status.copyWith(item: item);
    daysForExpire(
      DateTime.fromMicrosecondsSinceEpoch(item.advertisement.expiredDate),
    );

    final bool next = await LdConnection.validateConnection();

    if (next) {
      getBanks(context);
      getDocumentType(context);
      // TODO: consultar tipo de cuentas
      // getAccountsType(context);
    } else {
      // TODO: Mostrar alerta
    }
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

  void bankSelected(String id) {
    final int index = status.listBanks.data.indexWhere(
      // (Bank bank) => bank.id == id,
      (Bank bank) => bank.id == id,
    );
    if (index != -1) {
      status = status.copyWith(selectedBank: status.listBanks.data[index]);
    }
  }

  void accountTypeSelected(String id) {
    final int index = status.listAccountType.data.indexWhere(
      // (Bank bank) => bank.id == id,
      (DocType docType) => docType.id == id,
    );
    if (index != -1) {
      status = status.copyWith(
          selectedAccountType: status.listAccountType.data[index]);
    }
  }

  void docTypeSelected(String id) {
    final int index = status.listDocsType.data.indexWhere(
      (DocType docType) => docType.id == id,
    );
    if (index != -1) {
      status =
          status.copyWith(selectedDocType: status.listDocsType.data[index]);
    }
  }

  Future<void> getBanks(BuildContext context) async {
    status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );

    try {
      final ResponseData<ResultGetBanks> response =
          await _interactor.getBanks(pagination);
      if (response.isSuccess) {
        status = status.copyWith(listBanks: response.result);
      } else {
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get Banks Error As: $err');
    }
    status = status.copyWith(isLoading: false);
  }

  Future<void> getDocumentType(BuildContext context) async {
    status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );

    try {
      final ResponseData<ResultGetDocsType> response =
          await _interactor.getDocumentType(pagination);
      if (response.isSuccess) {
        status = status.copyWith(listDocsType: response.result);
      } else {
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get Type Docs Error As: $err');
    }
    status = status.copyWith(isLoading: false);
  }

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
    required Data item,
    required ResultDataUser userCurrent,
  }) async {
    status = status.copyWith(isLoading: true);

    /* String convertWorkKeccak(String word) {
      final SHA3 k1 = SHA3(256, KECCAK_PADDING, 256);
      k1.update(utf8.encode(word));
      final List<int> hash1 = k1.digest();
      return HEX.encode(hash1);
    } */

    final SmartContract smartContract = SmartContract(
      amount: item.advertisement.valueToSell,
      addressSeller: item.user.address,
      addressBuyer: userCurrent.addressWallet,
      //doubleHashedSecretsOfBuyer:
      //    '${convertWorkKeccak('${wordSecretBuyer}buyercancel')},${convertWorkKeccak('${wordSecretBuyer}buyeraprove')}',
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
