import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_effect.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_status.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/type_offer/data.dart';
import 'package:localdaily/services/models/detail_oper_offer/advertisement_document.dart';
import 'package:localdaily/services/models/detail_oper_offer/result_get_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement_documents.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/view_model.dart';

import 'detail_oper_offer_status.dart';

class DetailOperOfferViewModel
    extends EffectsViewModel<DetailOperOfferStatus, DetailOperOfferEffect> {
  late LdRouter _router;
  late ServiceInteractor _interactor;
  late String offerId;

  DetailOperOfferViewModel(
    this._router,
    this._interactor,
    this.offerId,
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
    );
  }

  Future<void> onInit(
      BuildContext context, ConfigurationProvider configurationProvider) async {
    status = status.copyWith();
    daysForExpire(
      DateTime.fromMicrosecondsSinceEpoch(1640901600000000),
    );

    final bool next = await LdConnection.validateConnection();
    status = status.copyWith(isLoading: true);
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

          response.result!.advertisementPayAccount!.forEach((account) {
            DocType _docType = listDocType
                .firstWhere((docType) => docType.id == account.documentTypeID);
            status = status.copyWith(docsType: [...?status.docsType, _docType]);
          });

          response.result!.advertisementPayAccount!.forEach((account) {
            Bank _bank =
                listBank.firstWhere((bank) => bank.id == account.bankId);
            status = status.copyWith(banks: [...status.banks, _bank]);
          });
          Data _isBuy = listTypeOffer.firstWhere((typeOffer) =>
              typeOffer.id == response.result!.idTypeAdvertisement);

          status = status.copyWith(isBuy: _isBuy == 'buy' ? true : false);
        });

        switch (status.item!.idStatus) {
          case '2':
            status = status.copyWith(state: 'Cerrado');
            break;
          case '1':
            if (status.listAdvertisementDoc.isEmpty) {
              status = status.copyWith(state: 'Pendiente de pago');
            } else {
              status = status.copyWith(state: 'Pagado');
            }
            break;
          case '0':
            status = status.copyWith(state: 'Publicado');
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
  ) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _router.goAttachedFile(
          context,
        );
      } else {
        addEffect(ShowSnackConnetivityEffect('Sin conexión a internet'));
      }
    });
  }

  void getDialog(BuildContext context, DetailOperOfferViewModel viewModel) {
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
  }
}
