import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_effect.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_status.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'detail_oper_offer_status.dart';

class DetailOperOfferViewModel
    extends EffectsViewModel<DetailOperOfferStatus, DetailOperOfferEffect> {
  late LdRouter _router;
  late ServiceInteractor _interactor;
  late dynamic item;

  DetailOperOfferViewModel(
    this._router,
    this._interactor,
    this.item,
  ) {
    status = DetailOperOfferStatus(
      isLoading: false,
      isError: true,
      item: item,
      dateOfExpire: '',
    );
  }

  Future<void> onInit(BuildContext context) async {
    status = status.copyWith(
      item: 'item',
    );
    daysForExpire(
      DateTime.fromMicrosecondsSinceEpoch(1640901600000000),
    );

    final bool next = await LdConnection.validateConnection();

    if (next) {
      // TODO: consultar tipo de cuentas
      // getAccountsType(context);
    } else {
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

  void daysForExpire(DateTime date) {
    final DateTime birthday = DateTime(date.year, date.month, date.day);
    final DateTime date2 = DateTime.now();
    final int difference = date2.difference(birthday).inDays;
    status = status.copyWith(dateOfExpire: difference.toString());
  }
}
