import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/entity_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'offer_buy_status.dart';

class OfferBuyViewModel extends ViewModel<OfferBuyStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  OfferBuyViewModel(
    this._route,
    this._interactor,
  ) {
    status = OfferBuyStatus(
      isMarginEmpty: true,
      totalMoney: '0',
      selectedBank: null,
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
    final String marginText = margin != '0 COP'
        ? margin.substring(
            0,
            margin.indexOf(' '),
          )
        : '';
    return marginText;
  }

  String _changeSeparatorGroup(String value) {
    if (value.contains('.')) {
      return value.replaceAll('.', ',');
    } else {
      return value.replaceAll(',', '.');
    }
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
    final double marginDouble = margin != ''
        ? double.parse(_changeSeparatorGroup(margin.split(' ').first))
        : 0;
    final double amountDLYDouble =
        amountDLY != '' ? double.parse(amountDLY.replaceAll('.', '')) : 0;

    final double total = marginDouble * amountDLYDouble;
    status = status.copyWith(
      totalMoney: _changeSeparatorGroup(NumberFormat().format(total)),
      isMarginEmpty: margin.toString().isEmpty,
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

  Future<void> getBank(BuildContext context) async {
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

  void goRegister(BuildContext context) {
    _route.goEmailRegister(context);
    LdConnection.validateConnection().then(
      (bool value) {
        if (value) {
          _route.goEmailRegister(context);
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    );
  }

  Future<void> createOfferBuy(
    BuildContext context, {
    required TextEditingController marginCtrl,
    required TextEditingController amountDLYCtrl,
    required String bankId,
    required TextEditingController infoPlusOfferCtrl,
    required String userId,
    required String wordSecret,
  }

      ) async {
    status = status.copyWith(isLoading: true);

    final EntityOffer entity = EntityOffer(
      idTypeAdvertisement: '138412e9-4907-4d18-b432-70bdec7940c4',
      idCountry: '138412e9-4907-4d18-b432-70bdec7940c4',
      valueToSell: amountDLYCtrl.text,
      margin: marginCtrl.text,
      termsOfTrade: infoPlusOfferCtrl.text,
      idUserPublish: userId,
      secretSellerKey: 'secreto1encryptado,secreto2encryptado'
    );
    final BodyOffer bodyOffer = BodyOffer(
      entity: entity,
      daysOfExpired: 7,
      strJsonAdvertisementBanks:
          //TODO, deberia ser diferente, ya que no se ingresan todos esos datos.
//        ,\"documentTypeID\" : \"c047a07c-2daf-48a7-ad49-ec447a93485b\",
          '[{\"bankId\": \"${bankId}\",\"accountNumber\": \"555555555\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"123456789\",\"documentTypeID\" : \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"titularUserName\": \"Roger Gutierrez\"},]',
    );

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         _interactor
        .createOffer(bodyOffer)
        .then((ResponseData<ResultCreateOffer> response) {
      print('Create offer Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Oferta de Compra creada EXITOSO!!');

        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
        print('no se pudo realizar la oferta de Compra!');
      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      print('Offera Error As: ${err}');
      status = status.copyWith(isLoading: false);
    });
  }
}
