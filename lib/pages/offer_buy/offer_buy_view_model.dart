import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/commons/ld_constans.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/offer_buy/offer_buy_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/entity_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/services/modules/offer_module.dart';
import 'package:localdaily/utils/values_format.dart';
import 'package:localdaily/view_model.dart';

import 'offer_buy_status.dart';

class OfferBuyViewModel
    extends EffectsViewModel<OfferBuyStatus, OfferBuyEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  OfferBuyViewModel(
    this._route,
    this._interactor,
  ) {
    status = OfferBuyStatus(
      isMarginEmpty: true,
      totalMoney: '0',
      isLoading: true,
      isError: true,
      listBanks: ResultGetBanks(
        data: <Bank>[],
        totalItems: 10,
        totalPages: 1,
      ),
    );
  }

  Future<void> onInit(
    BuildContext context, {
    bool validateNotification = false,
  }) async {
    getBank(context);
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
    final String marginText = margin == ''
        ? ''
        : !margin.contains(' ')
            ? '$margin COP'
            : margin;
    return marginText;
  }

  void calculateTotalMoney(String margin, String amountDLY) {
    double marginDouble = 0;
    if (margin.isNotEmpty) {
      if (margin.contains('COP')) {
        marginDouble = double.parse(margin.split(' ').first);
      } else {
        marginDouble = double.parse(margin);
      }
    }

    final double amountDLYDouble =
        amountDLY != '' ? double.parse(amountDLY.replaceAll('.', '')) : 0;

    final double total = marginDouble * amountDLYDouble;
    status = status.copyWith(
      totalMoney: ValueCurrencyFormat.format(total),
      isMarginEmpty: margin.isEmpty,
    );
  }

  void bankSelected(String id) {
    final int index = status.listBanks.data.indexWhere(
      (Bank bank) => bank.id == id,
    );
    if (index != -1) {
      status = status.copyWith(selectedBank: status.listBanks.data[index]);
    }
  }

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

  Future<void> getBank(BuildContext context) async {
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
        status.listBanks = response.result!;
      } else {
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get Banks Error As: $err');
    }
    status = status.copyWith(isLoading: false);
  }

  void goRegister(BuildContext context) {
    _route.goEmailRegister(context);
    LdConnection.validateConnection().then(
      (bool value) {
        if (value) {
          _route.goEmailRegister(context);
        } else {
          addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
        }
      },
    );
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

  Future<void> createOfferBuy(
    BuildContext context,
    DataUserProvider userProvider, {
    required String margin,
    required String amountDLY,
    required String infoPlusOffer,
    required String userId,
    required String wordSecret,
  }) async {
    closeDialog(context);
    status = status.copyWith(isLoading: true);

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
      idTypeAdvertisement: '3da2bc46-7ef5-4b65-9a81-e72facf11e5d',
      idCountry: '138412e9-4907-4d18-b432-70bdec7940c4',
      valueToSell: amountDLY.replaceAll('.', ''),
      margin: margin.split(' ').first,
      termsOfTrade: infoPlusOffer,
      idUserPublish: userId,
      hoursLimitPay: LdConstants.hoursLimitPay,
      //codeUserPublish:
      //    '${convertWorkKeccak('${wordSecret}sellercancel')},${convertWorkKeccak('${wordSecret}selleraprove')}',
    );
    final BodyOffer bodyOffer = BodyOffer(
      entity: entity,
      daysOfExpired: LdConstants.daysExpire,
      strJsonAdvertisementBanks: '',
    );

    userProvider.setBodyOffer(bodyOffer);
    await OfferModule.createOffer(context, userProvider, null, isBuy: true);
    status = status.copyWith(isLoading: false);
  }
}
