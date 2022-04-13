import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/commons/ld_constans.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/offer_sale/offer_sale_effect.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/entity_offer.dart';
import 'package:localdaily/services/models/create_offers/type_offer/result_type_offer.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/utils/crypto_utils.dart';
import 'package:localdaily/utils/midaily_connect.dart';
import 'package:localdaily/utils/values_format.dart';
import 'package:localdaily/view_model.dart';

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
      isAccountNumEmpty: true,
      isDocNumUserEmpty: true,
      isNameTitularAccountEmpty: true,
    );
  }

  Future<void> onInit(
    BuildContext context,
    ConfigurationProvider configurationProvider, {
    bool validateNotification = false,
  }) async {
    status = status.copyWith(
      listBanks: configurationProvider.getResultBanks,
      listDocsType: configurationProvider.getResultDocsTypes,
    );
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

  String? validatorAmount(String? value) {
    if (value == null || value.isEmpty || value == '0' || value == '0 COP') {
      return '* Campo necesario';
    } else if (double.parse(value.replaceAll('.', '')) < 1000) {
      return 'El valor mínimo es de 1.000';
    }
    return null;
  }

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

  void closeDialog(BuildContext context) {
    _route.pop(context);
  }

  Future<void> onClickCreateOffer() async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      addEffect(ValidateOfferEffect());
    } else {
      addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
    }
  }

  Future<void> createOfferSale(
    BuildContext context,
    DataUserProvider userProvider,
    ResultTypeOffer typeOffer, {
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
    closeDialog(context);
    final String total = (int.parse(amountDLY) +
            double.parse(status.feeMoney.replaceAll('.', '')))
        .toStringAsFixed(0);

    // Se valida que tenga una address recuperada
    final String _from = userProvider.getAddress ?? '';
    if (_from.isEmpty) {
      addEffect(WithoutAddressEffect());
      return;
    }

    // Se valida el monto con el balance para solicitar creacion
    if (double.parse(total) > await CryptoUtils().getBalance(_from)) {
      addEffect(WithoutFoundsEffect());
      return;
    }

    status = status.copyWith(isLoading: true);

    await MiDailyConnect.createConnection(
      context,
      DailyConnectType.transaction,
      total,
      'create',
    );

    /* String convertWorkKeccak(String word) {
      final SHA3 k1 = SHA3(256, KECCAK_PADDING, 256);
      final SHA3 k2 = SHA3(256, KECCAK_PADDING, 256);
      k1.update(utf8.encode(word));
      final List<int> hash1 = k1.digest();
      k2.update(hash1);
      final List<int> hash2 = k2.digest();
      return HEX.encode(hash2);
    } */

    final EntityOffer entity = EntityOffer(
      idTypeAdvertisement: typeOffer.data
          .firstWhere((element) => element.code == TypeOffer.sell.index)
          .id,
      idCountry: '809b4025-bf15-43f8-9995-68e3b7c53be6',
      valueToSell: amountDLY,
      margin: margin.split(' ').first,
      termsOfTrade: infoPlusOffer,
      idUserPublish: userId,
      hoursLimitPay: LdConstants.hoursLimitPay,
    );

    final BodyOffer bodyOffer = BodyOffer(
      entity: entity,
      daysOfExpired: LdConstants.daysExpire,
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

    userProvider.setBodyOffer(bodyOffer);
    // La publicación se crea en Midaily_connect ya que esta escuchando la respuesta de la transacción.
    status = status.copyWith(isLoading: false);
  }

  String resetValueMargin(String margin) {
    String marginText = '';
    if (margin.contains('COP')) {
      marginText = margin.substring(0, margin.indexOf(' '));
    } else {
      marginText = margin;
    }

    return marginText;
  }

  String completeEditMargin(String margin) {
    FocusManager.instance.primaryFocus?.unfocus();
    String marginText = '';

    if (margin.length == 2 && margin.contains('.') && !margin.contains(' ')) {
      marginText = '${margin}0 COP';
    } else if (!margin.contains(' ')) {
      marginText = '${margin.isEmpty ? 0 : margin} COP';
    } else if (margin.contains('COP')) {
      marginText = margin;
    } else {
      marginText = '0 COP';
    }

    return marginText;
  }

  String changeSeparatorGroup(String value) {
    if (value.contains('.')) {
      return value.replaceAll('.', ',');
    } else {
      return value.replaceAll(',', '.');
    }
  }

  // Total en DLYCOP que va a recibir el comprador
  String getTotalDlycopSold(String? amount) {
    return ValueCurrencyFormat.format(
      int.parse(amount ?? '0') -
          double.parse(status.feeMoney.replaceAll('.', '')),
    );
  }

  // Total en COP que debe pagar el comprador
  String getTotalCopToPay(String? amount) {
    return ValueCurrencyFormat.format(
      int.parse(amount ?? '0') * double.parse(status.costDLYtoCOP),
    );
  }

  // Total en DLYCOP que debe pagar el que publica la oferta
  String getTotalAddToPay(String? amount) {
    return ValueCurrencyFormat.format(
      int.parse(amount ?? '0') +
          double.parse(status.feeMoney.replaceAll('.', '')),
    );
  }

  void calculateTotalMoney(String marginText, String amountDLYText) {
    final String amountDLYWithoutDot = amountDLYText.replaceAll('.', '');
    final String marginWithoutString = marginText.contains(' ')
        ? marginText.split(' ').first.replaceAll(',', '.')
        : marginText.replaceAll(',', '.');

    final double margin =
        marginText != '' ? double.parse(marginWithoutString) : 0;
    final double amountDLY =
        amountDLYText != '' ? double.parse(amountDLYWithoutDot) : 0;
    final double total = (margin * amountDLY).roundToDouble();

    // TODO: El fee debe ser un servicio
    final int fee = (amountDLY * LdConstants.fee).round();
    final double totalPLUSfee = total + fee;

    status = status.copyWith(
      totalMoney: changeSeparatorGroup(NumberFormat().format(totalPLUSfee)),
      costDLYtoCOP: changeSeparatorGroup(NumberFormat().format(margin))
          .replaceAll(',', '.'),
      feeMoney: changeSeparatorGroup(NumberFormat().format(fee)),
      isMarginEmpty: marginText.isEmpty,
    );
  }
}
