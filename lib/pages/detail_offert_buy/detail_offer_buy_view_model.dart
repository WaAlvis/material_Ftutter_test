import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offerts/offert/body_offert.dart';
import 'package:localdaily/services/models/create_offerts/offert/entity_offer.dart';
import 'package:localdaily/services/models/create_offerts/offert/result_create_offert.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'detail_offer_buy_status.dart';

class DetailOfferBuyViewModel extends ViewModel<DetailOfferBuyStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  DetailOfferBuyViewModel(
    this._route,
    this._interactor,
  ) {
    status = DetailOfferBuyStatus(
      isLoading: false,
      isError: true,
    );
  }

  Future<void> onInit(BuildContext context) async {
    // getBank(context);
  }

  String? validatorNotEmpty(String? valueText) {
    if (valueText == null || valueText.isEmpty) {
      return '* Secreto necesario';
    }
    return null;
  }
}
