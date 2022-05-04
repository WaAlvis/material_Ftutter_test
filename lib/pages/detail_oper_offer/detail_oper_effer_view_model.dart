import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_effect.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_status.dart';
import 'package:localdaily/pages/detail_oper_offer/ui/detail_oper_offer_view.dart';
import 'package:localdaily/pages/info/ui/info_view.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/create_offers/type_offer/data.dart';
import 'package:localdaily/services/models/detail_offer/body_update_status.dart';
import 'package:localdaily/services/models/detail_oper_offer/advertisement_document.dart';
import 'package:localdaily/services/models/detail_oper_offer/confirm_payment/confirm_payment.dart';
import 'package:localdaily/services/models/detail_oper_offer/rate_user/rate_user.dart';
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
      dateOfExpire: 0,
      listAdvertisementDoc: <AdvertisementDocument>[],
      banks: <Bank>[],
      docsType: <DocType>[],
      isBuy: true,
      item: null,
      state: '',
      isOper2: true,
      extensionFile: '',
      listAccountTypes: <AccountType>[],
      userId: '',
      rateUser: 0,
      dateHours: 0,
    );
  }

  Future<void> onInit(
      BuildContext context,
      ConfigurationProvider configurationProvider,
      DataUserProvider dataUserProvider) async {
    status = status.copyWith();

    final bool next = await LdConnection.validateConnection();
    status = status.copyWith(isLoading: true);
    status = status.copyWith(isOper2: isOper == 'Operacion' ? true : false);
    status = status.copyWith(userId: dataUserProvider.getDataUserLogged!.id);
    print('${status.isOper2} que esta llegando');
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
              status = status.copyWith(
                resultAccountTypes: <AccountType>[
                  ...?status.listAccountTypes,
                  _accountType
                ],
              );
            });
          } catch (e) {
            print('$e accounttype');
          }

          try {
            response.result!.advertisementPayAccount!.forEach((account) {
              DocType _docType = listDocType.firstWhere(
                  (docType) => docType.id == account.documentTypeID);
              status = status
                  .copyWith(docsType: <DocType>[...?status.docsType, _docType]);
            });
          } catch (e) {
            print('$e typedoc');
          }

          try {
            response.result!.advertisementPayAccount!.forEach((account) {
              Bank _bank =
                  listBank.firstWhere((bank) => bank.id == account.bankId);
              status = status.copyWith(banks: [...status.banks, _bank]);
            });
          } catch (e) {
            print('$e banks');
          }

          try {
            Data _isBuy = listTypeOffer.firstWhere((typeOffer) =>
                typeOffer.id == response.result!.idTypeAdvertisement);

            status = status.copyWith(
                isBuy: _isBuy.description == 'Buy'
                    ? status.isOper2
                        ? false
                        : true
                    : status.isOper2
                        ? true
                        : false);
          } catch (e) {
            print('$e isbuy');
          }

          try {
            daysForExpire(
              DateTime.fromMillisecondsSinceEpoch(
                response.result!.expiredDate,
              ),
            );
            hoursForExpire(
              DateTime.fromMillisecondsSinceEpoch(
                response.result!.modificationDate,
              ),
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

            break;
          case '1':
            if (status.listAdvertisementDoc.isEmpty) {
              status = status.copyWith(state: 'Pendiente de pago');
            } else {
              status = status.copyWith(state: 'Pagado');

              status = status.copyWith(
                extensionFile: status.listAdvertisementDoc[0].fileExtension,
              );
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
      // status = status.copyWith(state: 'Pagado', isBuy: false, isOper2: true);
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
      title: isBuy
          ? isOper
              ? '¿Ya no quieres comprar estos DLYCOP?'
              : '¿Quieres quitar esta publicación?'
          : isOper
              ? '¿Ya no quieres vender estos DLYCOP?'
              : '¿Quieres quitar esta publicación?',
      message: isBuy
          ? isOper
              ? 'Piénsalo un poco más. El sistema te dará una mala calificación y perderás la oportunidad de tener más DLYCOP.'
              : 'Piensalo un poco más. Perderás lo oportunidad de obtener más Dailys.\n\n¿Estás seguro de hacer esto?'
          : isOper
              ? 'Piénsalo un poco más. El sistema te dará una mala calificación y perderás la oportunidad de ganar dinero.'
              : 'Piensalo un poco más. Perderás lo oportunidad de obtener más Dailys.\n\n¿Estás seguro de hacer esto?',
      btnText: isBuy
          ? isOper
              ? 'Sí, cancelar la compra'
              : 'Sí, quitar'
          : 'Sí, cancelar la venta',
      onTap: () {
        cancelAdvertisement(context);
      },
      btnTextSecondary: 'Cancelar',
      onTapSecondary: () => viewModel.closeDialog(context),
    );
  }

  void getDialogConfirmPay(
    BuildContext context,
    DetailOperOfferViewModel viewModel,
  ) {
    return LdDialog.buildDenseAlertDialog(
      context,
      image: LdAssets.payConfirm,
      title: 'Confirmar pago',
      message:
          'Estas a punto de confirmar que recibiste completo el pago del comprador y el comprobante es verdadero. \n\n¿Quieres confirmar el pago?',
      btnText: 'Sí, confirmar',
      onTap: () {
        confirmPay(context, viewModel);
      },
      btnTextSecondary: 'Cancelar',
      onTapSecondary: () => viewModel.closeDialog(context),
    );
  }

  Future<void> confirmPay(
    BuildContext context,
    DetailOperOfferViewModel viewModel,
  ) async {
    closeDialog(context);
    status = status.copyWith(isLoading: true);

    ConfirmPayment body = ConfirmPayment(
      idAvertisement: offerId,
      addressDestiny: '',
      value: '2',
      message: 'Usuario confirmo orden de pago',
    );

    final RateUser bodyRate = RateUser(
      isSeller: true,
      userId: status.item!.idUserPublish,
      rate: status.rateUser!.toString(),
      advertisementId: status.item!.id,
    );
    try {
      await _interactor.confirmPayment(body).then((response) {
        InfoViewArguments info = InfoViewArguments(
            title: '¡Dailys entregados!',
            description:
                'Tus Dailys fueron entregados exitosamente al comprador.',
            imageType: ImageType.success,
            pageTitle: ' ',
            customWidget: CardRateUser(
              viewModel: viewModel,
            ),
            onAction: () async {
              if (status.rateUser! > 0.0) {
                try {
                  await _interactor.addRateUser(bodyRate).then((response) {
                    final statusCode = response.result.statusCode;
                    if (response.isSuccess) {
                      try {
                        closeDialog(context);
                        _router.goDetailOperOffer(
                          context,
                          offerId,
                          status.isOper2 ? 'Operacion' : 'Oferta',
                          replace: true,
                        );
                      } catch (e) {
                        print('info $e');
                      }
                    } else {
                      print('statusCode $statusCode');
                    }
                  });
                } catch (e) {
                  print('$e ');
                }
              } else {
                print('${status.rateUser} rate user');

                // addEffect(
                //     ShowSnackbarErrorEffect('Por favor califique al usuario'));
              }
            });
        _router.goInfoView(context, info);
        status = status.copyWith(isLoading: false);
      });
    } catch (e) {
      addEffect(ShowSnackbarErrorEffect(e.toString()));
      status = status.copyWith(isLoading: false);
    }
  }

  Future<void> cancelAdvertisement(BuildContext context) async {
    closeDialog(context);

    status = status.copyWith(isLoading: true);
    final BodyUpdateStatus body = BodyUpdateStatus(
      idAdvertisement: offerId,
      idUserInteraction: status.userId!,
      statusOrigin: int.parse(status.item!.idStatus),
      statusDestiny: 2,
      //OfferStatus.closed,
      successfulTransaction:
          status.userId != status.item!.idUserPublish ? true : false,
    );

    try {
      await _interactor.reserveOffer(body).then((response) {
        InfoViewArguments info = InfoViewArguments(
          title: '¡Cancelada!',
          description: status.isOper2
              ? "Se canceló exitosamente la ${status.isBuy ? 'compra' : 'venta'}."
              : 'Se quitó exitosamente una publicación.',
          imageType: ImageType.success,
          pageTitle: ' ',
          onAction: () {
            print('pantalla nueva ');

            try {
              closeDialog(context);
              _router.goDetailOperOffer(
                context,
                offerId,
                status.isOper2 ? 'Operacion' : 'Oferta',
                replace: true,
              );
            } catch (e) {
              print('pantalla nueva $e');
            }
          },
        );
        _router.goInfoView(context, info);

        status = status.copyWith(isLoading: false);
      });
    } catch (e) {
      print(e);
    }
  }

  void daysForExpire(DateTime date) {
    final DateTime birthday = DateTime(date.year, date.month, date.day);
    final DateTime date2 = DateTime.now();
    final int difference = date2.difference(birthday).inDays;
    status = status.copyWith(dateOfExpire: difference);
    // print('status.dateOfExpire pasada al header ${status.dateOfExpire}');
  }

  void hoursForExpire(DateTime date) {
    final DateTime date2 = DateTime.now();
    final int difference = date2.difference(date).inHours;
    status = status.copyWith(dateHours: difference);
    // print('$difference   horas pasada al header ${status.dateHours}');
  }
}
