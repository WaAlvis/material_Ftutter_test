import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/contact_support/contact_support_effect.dart';
import 'package:localdaily/pages/contact_support/contact_support_status.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/services/models/contact_support/support_type/result_support_type.dart';
import 'package:localdaily/view_model.dart';

class ContactSupportViewModel
    extends EffectsViewModel<ContactSupportStatus, ContactSupportEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  late String advertisementId;
  late int reference;
  late bool isbuy;

  ContactSupportViewModel(
    this._route,
    this._interactor,
    this.advertisementId,
    this.reference, {
    required this.isbuy,
  }) {
    status = ContactSupportStatus(
      isLoading: false,
      isError: false,
      isBuy: isbuy,
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
      idPublish: advertisementId,
      idUserPublish: userId,
      description: status.description,
      email: email,
      idSupportType: idSupportType,
      id: '',
      datePublish: '',
      dateSolution: '',
      idSupportStatus: '',
      idUserSupport: '',
      jiraLink: '',
    );
    print(body.toJson());
    try {
      await _interactor.createContactSupport(body).then((response) {
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
