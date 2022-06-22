import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/contact_support/contact_support_effect.dart';
import 'package:localdaily/pages/contact_support/contact_support_status.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/services/models/contact_support/support_type/result_support_type.dart';
import 'package:localdaily/services/models/detail_offer/body_update_status.dart';
import 'package:localdaily/view_model.dart';
import 'package:provider/provider.dart';

class ContactSupportViewModel
    extends EffectsViewModel<ContactSupportStatus, ContactSupportEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  late String advertisementId;
  late int reference;
  late bool isbuy;
  late bool isDisputa;

  ContactSupportViewModel(
    this._route,
    this._interactor,
    this.advertisementId,
    this.reference, {
    required this.isbuy,
    required this.isDisputa,
  }) {
    status = ContactSupportStatus(
      isLoading: false,
      isError: false,
      isBuy: isbuy,
      isDisputa: isDisputa,
      description: '',
    );
  }

  Future<void> onInit() async {}

  String? validatorNotEmpty(String? valueText) {
    if (valueText == null || valueText.isEmpty) {
      return '* Campo necesario';
    }
    return null;
  }

  void changeDescription(String description) => status = status.copyWith(
        description: description,
      );

  Future<void> onClickContactSupport() async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      addEffect(CreateContactSupportEffect());
    } else {
      addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
    }
  }

  Future<void> createContactSupport(
    String email,
    String userId,
    bool isDisputa,
    BuildContext context,
    ResultSupportType? supportTypes,
  ) async {
    status = status.copyWith(isLoading: true);
    addEffect(ShowLoadingEffect());

    String idSupportType = '';
    if (supportTypes != null) {
      final int index = supportTypes.data.indexWhere(
        (element) => isbuy
            ? element.description == SupportType.LocalDLYBuy.name
            : element.description == SupportType.LocalDLYSale.name,
      );
      if (index != -1) {
        idSupportType = supportTypes.data[index].id;
      }
    }

    final BodyContactSupport body = BodyContactSupport(
      idAdvertisement: advertisementId,
      idUserPublish: userId,
      description: status.description,
      emailUserPublish: email,
      idSupportType: idSupportType,
      jiraKey: '',
      userPublishNickname: '',
      id: '',
      datePublish: '',
      dateSolution: '',
      idSupportStatus: '',
      idUserSupport: '',
      jiraLink: '',
    );

    final BodyUpdateStatus bodyStatus = BodyUpdateStatus(
      idAdvertisement: advertisementId,
      idUserInteraction: userId,
      statusOrigin: 1,
      statusDestiny: 4,
      successfulTransaction: true,
    );

    try {
      final DataUserProvider dataUserProvider =
          context.read<DataUserProvider>();
      final token = dataUserProvider.getTokenLogin;
      await _interactor
          .createContactSupport(body, 'Bearer ${token!.token}')
          .then((response) async {
        print('${isDisputa} @#@#');

        if (isDisputa) {
          print('${bodyStatus.toJson()} @#@#');
          final DataUserProvider dataUserProvider =
              context.read<DataUserProvider>();

          final token = dataUserProvider.getTokenLogin;
          await _interactor
              .reserveOffer(bodyStatus, 'Bearer ${token!.token}')
              .then((response) => {
                    if (response.isSuccess)
                      {
                        addEffect(ShowSnackbarSuccesEffect()),
                      }
                    else
                      {
                        addEffect(
                          ShowSnackbarErrorEffect(
                            'No fue posible enviar el caso de soporte/disputa, intenta más tarde',
                          ),
                        )
                      }
                  });
          status = status.copyWith(isLoading: false);
          _route.pop(context);
          if (response.isSuccess) {
            addEffect(ShowSnackbarSuccesEffect());
            _route.goHome(context);
          } else {
            addEffect(
              ShowSnackbarErrorEffect(
                'No fue posible enviar el caso de soporte, intenta más tarde',
              ),
            );
          }
        }
      });
    } catch (e) {
      addEffect(
        ShowSnackbarErrorEffect(
          'No fue posible enviar el caso de soporte, intenta más tarde',
        ),
      );
      _route.pop(context);
      status = status.copyWith(isLoading: false);
    }
  }
}
