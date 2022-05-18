import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_constans.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_offer/detail_offer_effect.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/detail_offer/body_add_pay_account.dart';
import 'package:localdaily/services/models/detail_offer/body_update_status.dart';
import 'package:localdaily/services/models/detail_offer/result_update_status.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/utils/midaily_connect.dart';
import 'package:localdaily/utils/values_format.dart';
import 'package:localdaily/view_model.dart';

import 'detail_offer_status.dart';

class DetailOfferViewModel
    extends EffectsViewModel<DetailOfferStatus, DetailOfferEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;
  final Data item;
  final bool isBuy;

  DetailOfferViewModel(
    this._route,
    this._interactor,
    this.item, {
    required this.isBuy,
  }) {
    status = DetailOfferStatus(
      isLoading: false,
      isError: true,
      item: item,
      dateOfExpire: '',
      isBuy: isBuy,
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
      listAccountType: <AccountType>[],
      listAccountTypeB: <AccountType>[],
    );
  }

  Future<void> onInit(
    BuildContext context,
    ConfigurationProvider configurationProvider,
  ) async {
    daysForExpire(
      DateTime.fromMicrosecondsSinceEpoch(item.advertisement.expiredDate),
    );

    status = status.copyWith(
      item: item,
      isBuy: isBuy,
      listBanks: configurationProvider.getResultBanks,
      listDocsType: configurationProvider.getResultDocsTypes,
      listAccountType: configurationProvider.getResultAccountTypes,
    );
  }

  void goProfileSeller(
    BuildContext context, {
    required String idUser,
    required String nickName,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goProfileSeller(
          context,
          idUser,
          nickName,
        );
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
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
      return '* Campo necesario';
    }
    return null;
  }

  void bankSelected(String id) {
    final int index = status.listBanks.data.indexWhere(
      (Bank bank) => bank.id == id,
    );
    if (index != -1) {
      status = status.copyWith(
        selectedBank: status.listBanks.data[index],
      );
      if (status.selectedBank?.description == 'NEQUI' ||
          status.selectedBank?.description == 'DAVIPLATA') {
        status = status.copyWith(
          listAccountTypeB: <AccountType>[
            AccountType(
              description: 'Billetera virutal',
              id: '998ea2c8-aac4-11ec-9cf0-5740eef20236',
            )
          ],
        );
      } else {}
      // print(
      //     '${status.selectedBank?.description} listaccounttype ${status.selectedAccountType?.id}  listaccounttype ${status.selectedAccountType?.description}');
    }
  }

  void accountTypeSelected(String id) {
    final int index = status.listAccountType.indexWhere(
      (AccountType accountType) => accountType.id == id,
    );
    if (index != -1) {
      status = status.copyWith(
        selectedAccountType: status.listAccountType[index],
      );
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

  String calculateFee(String amount) {
    return ValueCurrencyFormat.format(double.parse(amount) * LdConstants.fee);
  }

  String calculateTotalReceive(
    String amount,
    String margin, {
    bool isBuy = false,
  }) {
    if (isBuy) {
      return ValueCurrencyFormat.format(
        double.parse(amount) * double.parse(margin),
      );
    } else {
      return ValueCurrencyFormat.format(
        double.parse(amount) - (double.parse(amount) * LdConstants.fee),
      );
    }
  }

  String calculateTotalTransfer(
    String amount,
    String margin, {
    bool isBuy = false,
  }) {
    if (isBuy) {
      return ValueCurrencyFormat.format(
        double.parse(amount) + (double.parse(amount) * LdConstants.fee),
      );
    } else {
      return ValueCurrencyFormat.format(
        double.parse(amount) * double.parse(margin),
      );
    }
  }

  void closeDialog(BuildContext context) {
    _route.pop(context);
  }

  Future<void> onClickReserveDly() async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      addEffect(ValidateOfferEffect());
    } else {
      addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
    }
  }

  String getBankById(String id, List<Bank> listBanks) {
    return listBanks.firstWhere((element) => element.id == id).description;
  }

  Future<void> onClicConfirmkReserveDly(
      BuildContext context, VoidCallback action) async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      _route.pop(context);
      addEffect(ConfirmOfferEffect(action));
    } else {
      addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
    }
  }

  Future<void> reservationPaymentForDly(
    BuildContext context, {
    required Data item,
    required ResultDataUser userCurrent,
    required TypeOffer typeOffer,
    required DataUserProvider userProvider,
    required String accountNo,
    required String docNum,
    required String titular,
  }) async {
    closeDialog(_route.navigatorKey.currentContext!);
    status = status.copyWith(isLoading: true);

    final BodyUpdateStatus body = BodyUpdateStatus(
      idAdvertisement: item.advertisement.id,
      idUserInteraction: userCurrent.id,
      statusOrigin: OfferStatus.Publicado.index,
      statusDestiny: typeOffer == TypeOffer.buy
          ? OfferStatus.pending.index
          : OfferStatus.Pendiente.index,
      successfulTransaction: true,
    );

    if (typeOffer == TypeOffer.sell) {
      _interactor
          .reserveOffer(body)
          .then((ResponseData<ResultUpdateStatus> response) {
        if (response.isSuccess) {
          addEffect(ShowSnackbarSuccesEffect());
          _route.goHome(_route.navigatorKey.currentContext!);
        } else {
          addEffect(
            ShowSnackbarErrorEffect(
              'No fue posible separar la oferta, intenta más tarde',
            ),
          );
          print('Reserve Error As: ${response.error?.message}');
        }
        status = status.copyWith(isLoading: false);
      }).catchError((err) {
        addEffect(
          ShowSnackbarErrorEffect(
            'No fue posible separar la oferta, intenta más tarde',
          ),
        );
        print('Reserve Error As: ${err}');
        status = status.copyWith(isLoading: false);
      });
    } else {
      final String total = (double.parse(item.advertisement.valueToSell) +
              (double.parse(item.advertisement.valueToSell) * LdConstants.fee))
          .toStringAsFixed(0);

      final BodyAddPayAccount bodyBanks = BodyAddPayAccount(
        advertisementId: item.advertisement.id,
        strJsonAdvertPayAccount: json.encode([
          <String, dynamic>{
            'bankId': status.selectedBank!.id,
            'accountNumber': accountNo,
            'accountTypeId': status.selectedAccountType!.id,
            'documentNumber': docNum,
            'documentTypeID': status.selectedDocType!.id,
            'titularUserName': titular,
          }
        ]),
      );

      userProvider.setBodyUpdateStatus(body);
      userProvider.setBodyAddPayAccount(bodyBanks);

      await MiDailyConnect.createConnection(
        _route.navigatorKey.currentContext!,
        DailyConnectType.transaction,
        total,
        'reserve',
      );
    }
    status = status.copyWith(isLoading: false);
  }
}
