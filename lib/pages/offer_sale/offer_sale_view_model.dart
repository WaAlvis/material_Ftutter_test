import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/offer_sale/offer_sale_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/entity_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:hex/hex.dart';
import 'package:sha3/sha3.dart';

import 'offer_sale_status.dart';

class OfferSaleViewModel
    extends EffectsViewModel<OfferSaleStatus, OfferSaleEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  OfferSaleViewModel(
    this._route,
    this._interactor,
  ) {
    status = OfferSaleStatus(
      isMarginEmpty: true,
      costDLYtoCOP: '1',
      feeMoney: '0',
      totalMoney: '',
      selectedDocType: null,
      selectedAccountType: null,
      selectedBank: null,
      isLoading: false,
      isError: true,
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
              isActive: true),
          DocType(
              id: 'c047a07c-2daf-48a7-ad49-ec447a93485b',
              countryId: '17cccd6d-1675-485b-806b-5297063e6826',
              description: 'Ahorros',
              isActive: true),
        ],
        totalItems: 10,
        totalPages: 1,
      ),
      isAccountNumEmpty: true,
      isDocNumUserEmpty: true,
      isNameTitularAccountEmpty: true,
    );
  }

  Future<void> onInit(
    BuildContext context, {
    bool validateNotification = false,
  }) async {
    getBanks(context);
    getDocumentType(context);
    // getAccountsType(context);
  }

  void goRegister(BuildContext context) {
    _route.goEmailRegister(context);
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goEmailRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
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

  void changeNameTitularAccount(String name) =>
      status = status.copyWith(isNameTitularAccountEmpty: name.isEmpty);

  String? validatorNotEmpty(String? valueText) {
    if (valueText == null ||
        valueText.isEmpty ||
        valueText == '0' ||
        valueText == '0 COP') {
      return '* Campo necesario';
    }
    return null;
  }

  // {
  //   {
  //     if (valueText == null || valueText.isEmpty) {
  //       return '* Campo necesario';
  //     }
  //     return null;
  //   }
  // }

  void changeDocNumUser(String docNum) =>
      status = status.copyWith(isDocNumUserEmpty: docNum.isEmpty);

  void changeAccountNumInput(String accountNum) =>
      status = status.copyWith(isAccountNumEmpty: accountNum.isEmpty);

  void docTypeSelected(String id) {
    final int index = status.listDocsType.data.indexWhere(
      // (Bank bank) => bank.id == id,
      (DocType docType) => docType.id == id,
    );
    if (index != -1) {
      status =
          status.copyWith(selectedDocType: status.listDocsType.data[index]);
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

  Future<void> getDocumentType(BuildContext context) async {
    // status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: 1,
      itemsPerPage: 25,
    );

    try {
      final ResponseData<ResultGetDocsType> response =
          await _interactor.getDocumentType(pagination);
      print('Type Docs list Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Exito obteniendo la data de Tipos de DOCS!!');
        status.listDocsType = response.result!;
      } else {
        print('ERROR obteniendo la data de Tipos de DOCS');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get Type Docs Error As: $err');
    }
    status = status.copyWith(isLoading: false);
  }

  Future<void> getBanks(BuildContext context) async {
    status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: 1,
      itemsPerPage: 25,
    );

    try {
      final ResponseData<ResultGetBanks> response =
          await _interactor.getBanks(pagination);
      print('Baks list Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Exito obteniendo la data Los BANCOS!!');
        status.listBanks = response.result!;
      } else {
        print('ERROR obteniendo la data de Baks');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get Banks Error As: $err');
    }
    status = status.copyWith(isLoading: false);
  }

  Future<void> onClickCreateOffer() async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      addEffect(ValidateOfferEffect());
    } else {
      //addEffect(ShowSnackbarConnectivityEffect(_i18n.noConnection));
    }
  }

  Future<void> createOfferSale(
    BuildContext context, {
    required String userId,
    required String margin,
    required String amountDLY,
    required String bankId,
    required String accountTypeId,
    required String accountNum,
    required String docType,
    required String docNum,
    required String nameTitularAccount,
    required String infoPlusOffer,
    required String wordSecret,
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

    final EntityOffer entity = EntityOffer(
      idTypeAdvertisement: '138412e9-4907-4d18-b432-70bdec7940c4',
      idCountry: '809b4025-bf15-43f8-9995-68e3b7c53be6',
      valueToSell: amountDLY.replaceAll('.', ''),
      margin: margin.split(' ').first,
      termsOfTrade: infoPlusOffer,
      idUserPublish: userId,
      codeUserPublish: '',
      //codeUserPublish:
      //    '${convertWorkKeccak('${wordSecret}sellercancel')},${convertWorkKeccak('${wordSecret}selleraprove')}',
    );

    final BodyOffer bodyOffer = BodyOffer(
      entity: entity,
      daysOfExpired: 7,
      strJsonAdvertisementBanks: json.encode([
        <String, dynamic>{
          'bankId': bankId,
          'accountNumber': accountNum,
          'accountTypeId': accountTypeId,
          'documentNumber': docNum,
          'documentTypeID': docType,
          'titularUserName': nameTitularAccount,
        }
      ]),
    );
    //'[{\"bankId\": \"$bankId\",\"accountNumber\": \"$accountNum\",\"accountTypeId\": \"$accountTypeId\",\"documentNumber\": \"$docNum\",\"documentTypeID\" : \"$docType\",\"titularUserName\": \"$nameTitularAccount\"},]');
    //'[{\"bankId\": \"$bankId\",\"accountNumber\": \"$accountNum\",\"accountTypeId\": \"$accountTypeId\",\"documentNumber\": \"$docNum\",\"documentTypeID\" : \"$docType\",\"titularUserName\": \"$nameTitularAccount\"},]');
// "[{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\": \"555555555\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"123456789\",\"documentTypeID\" : \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"titularUserName\": \"Roger Gutierrez\"},{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\":\"101010101\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentTypeID\" : \"eb2e8229-13ee-4282-b053-32e7b444ea10\",\"documentNumber\": \"987654321\",\"titularUserName\": \"Carmen Martinez\"}]"
    _interactor
        .createOffer(bodyOffer)
        .then((ResponseData<ResultCreateOffer> response) {
      print('Create offer Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Oferta de venta creada EXITOSO!!');

        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
        print('no se pudo realizar la oferta ve venta!');
      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      print('Offer Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
  }

  String resetValueMargin(String margin) {
    final String marginText =
        margin != '0 COP' ? margin.substring(0, margin.indexOf(' ')) : '';
    return marginText;
  }

  String completeEditMargin(String margin) {
    FocusManager.instance.primaryFocus?.unfocus();
    final String marginText = margin == ''
        ? ''
        : !margin.contains(' ')
            ? '$margin COP'
            : margin;
    return marginText;
  }

  String changeSeparatorGroup(String value) {
    if (value.contains('.')) {
      return value.replaceAll('.', ',');
    } else {
      return value.replaceAll(',', '.');
    }
  }

  void calculateTotalMoney(String marginText, String amountDLYText) {
    final String amountDLYWithoutDot = amountDLYText.replaceAll('.', '');
    final String marginWithoutString =
        marginText.split(' ').first.replaceAll(',', '.');

    final double margin =
        marginText != '' ? double.parse(marginWithoutString) : 0;
    final double amountDLY =
        amountDLYText != '' ? double.parse(amountDLYWithoutDot) : 0;
    final double total = margin * amountDLY;
    final int fee = (total * 0.01).toInt();
    final double totalPLUSfee = total + fee;

    status = status.copyWith(
      totalMoney: changeSeparatorGroup(NumberFormat().format(totalPLUSfee)),
      costDLYtoCOP: changeSeparatorGroup(NumberFormat().format(margin)),
      feeMoney: changeSeparatorGroup(NumberFormat().format(fee)),
      isMarginEmpty: marginText.isEmpty,
    );
  }
}

// Future<void> getAccountsType(BuildContext context) async {
//   // status = status.copyWith(isLoading: true);
//
//   final Pagination pagination = Pagination(
//     isPaginable: true,
//     currentPage: 1,
//     itemsPerPage: 25,
//   );
//
//   try {
//     final ResponseData<ResultGetDocsType> response =
//     await _interactor.getDocumentType(pagination);
//     print('Type Docs list Res: ${response.statusCode} ');
//     if (response.isSuccess) {
//       print('Exito obteniendo la data de Tipos de DOCS!!');
//       status.listDocsType = response.result!;
//     } else {
//       print('ERROR obteniendo la data de Tipos de DOCS');
//       // TODO: Mostrar alerta
//     }
//   } catch (err) {
//     print('Get Type Docs Error As: $err');
//   }
//   status = status.copyWith(isLoading: false);
// }
