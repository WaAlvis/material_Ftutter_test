import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_effect.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_status.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/type_offer/data.dart';
import 'package:localdaily/services/models/detail_oper_offer/advertisement_document.dart';
import 'package:localdaily/services/models/detail_oper_offer/result_get_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement_documents.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement_pay_account.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/view_model.dart';

import 'detail_oper_offer_status.dart';

class DetailOperOfferViewModel
    extends EffectsViewModel<DetailOperOfferStatus, DetailOperOfferEffect> {
  late LdRouter _router;
  late ServiceInteractor _interactor;
  late String offerId;
  late String isOper;

  DetailOperOfferViewModel(
    this._router,
    this._interactor,
    this.offerId,
    this.isOper,
  ) {
    status = DetailOperOfferStatus(
      isLoading: false,
      isError: true,
      dateOfExpire: '',
      listAdvertisementDoc: <AdvertisementDocument>[],
      banks: <Bank>[],
      docsType: <DocType>[],
      isBuy: true,
      item: null,
      state: '',
      isOper: true,
      extensionFile: '',
      listAccountTypes: <AccountType>[],
    );
  }

  Future<void> onInit(
      BuildContext context, ConfigurationProvider configurationProvider) async {
    status = status.copyWith();

    final bool next = await LdConnection.validateConnection();
    status = status.copyWith(isLoading: true);
    status = status.copyWith(isOper: isOper == 'Operacion');
    if (next) {
      // TODO: consultar tipo de cuentas
      // getAccountsType(context);

      try {
        await _interactor.getDetailAdvertisement(offerId).then((response) {
          status = status.copyWith(isLoading: false);
          status = status.copyWith(item: response.result);
          status = status.copyWith(
            listAdvertisementDoc: response.result?.advertisementDocuments,
          );
          List<Bank> listBank = configurationProvider.getResultBanks!.data;
          List<DocType> listDocType =
              configurationProvider.getResultDocsTypes!.data;
          List<Data> listTypeOffer =
              configurationProvider.getResultTypeOffer!.data;
          List<AccountType>? listAccountTypes =
              configurationProvider.getResultAccountTypes;

          try {
            response.result!.advertisementPayAccount!
                .forEach((AdvertisementPayAccount account) {
              AccountType _accountType = listAccountTypes!.firstWhere(
                  (AccountType accountType) =>
                      accountType.id == account.accountTypeId);
              status = status.copyWith(resultAccountTypes: <AccountType>[
                ...status.listAccountTypes,
                _accountType
              ]);
            });
          } catch (e) {
            print('$e accounttype');
          }
          print('2');

          try {
            response.result!.advertisementPayAccount!.forEach((account) {
              DocType _docType = listDocType.firstWhere(
                  (docType) => docType.id == account.documentTypeID);
              status =
                  status.copyWith(docsType: [...?status.docsType, _docType]);
            });
          } catch (e) {
            print('$e typedoc');
          }
          print('3');

          try {
            response.result!.advertisementPayAccount!.forEach((account) {
              Bank _bank =
                  listBank.firstWhere((bank) => bank.id == account.bankId);
              status = status.copyWith(banks: [...status.banks, _bank]);
            });
          } catch (e) {
            print('$e banks');
          }
          print('4');

          try {
            Data _isBuy = listTypeOffer.firstWhere((typeOffer) =>
                typeOffer.id == response.result!.idTypeAdvertisement);

            status = status.copyWith(
                isBuy: _isBuy.description == 'Buy' ? true : false);
            print('status.isBuy  ${status.isBuy} _isbuy ${_isBuy.description}');
          } catch (e) {
            print('$e isbuy');
          }
          print('5');

          try {
            print('inicio del try');
            daysForExpire(
              DateTime.fromMillisecondsSinceEpoch(response.result!.expiredDate),
            );
          } catch (e) {
            print('$e expiredate');
          }
        });

        switch (status.item!.idStatus) {
          case '2':
            status = status.copyWith(state: 'Cerrado');
            status = status.copyWith(
                extensionFile: status.listAdvertisementDoc[0].fileExtension);
            print('Pagado');

            break;
          case '1':
            if (status.listAdvertisementDoc.isEmpty) {
              status = status.copyWith(state: 'Pendiente de pago');
              print('Pendiente de pago');
            } else {
              status = status.copyWith(state: 'Pagado');
              print('pago ${status.state}');

              status = status.copyWith(
                extensionFile: status.listAdvertisementDoc[0].fileExtension,
              );
              print('pagodo');
            }
            break;
          case '0':
            status = status.copyWith(state: 'Publicado');
            print('Publicado');

            break;
          default:
            status = status.copyWith(state: 'Publicado');
            break;
        }
      } catch (e) {
        addEffect(
          ShowSnackbarErrorEffect('Error desconocdio'),
        ); //cambiar mensaje
      }
      // status = status.copyWith(
      //     state: 'Pendiente de pago', isBuy: true, isOper: true);
    } else {
      status = status.copyWith(isLoading: false);

      // TODO: Mostrar alerta
    }
  }

  void closeDialog(BuildContext context) {
    _router.pop(context);
  }

  void goAttachedFile(
    BuildContext context,
    bool isOper,
    String isView,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _router.goAttachedFile(
          context,
          // isOper,
          offerId,
          status.extensionFile ?? '',
          isView,
        );
      } else {
        addEffect(ShowSnackConnetivityEffect('Sin conexión a internet'));
      }
    });
  }

  void getDialog(
    BuildContext context,
    DetailOperOfferViewModel viewModel,
    bool isBuy,
    bool isOper,
  ) {
    return LdDialog.buildDenseAlertDialog(
      context,
      image: LdAssets.cancelBuy,
      title: '¿Ya no quieres comprar estos DLYCOP?',
      message:
          'Piénsalo un poco más. El sistema te dará una mala calificación y perderás la oportunidad de tener más DLYCOP.',
      btnText: 'Cancelar la compra',
      onTap: () {},
      btnTextSecondary: 'Cancelar',
      onTapSecondary: () => viewModel.closeDialog(context),
    );
  }

  void daysForExpire(DateTime date) {
    final DateTime birthday = DateTime(date.year, date.month, date.day);
    final DateTime date2 = DateTime.now();
    final int difference = date2.difference(birthday).inDays;
    status = status.copyWith(dateOfExpire: difference.toString());
    print('status.dateOfExpire ${difference.toString()}');
    print(difference.toString());
  }
}
