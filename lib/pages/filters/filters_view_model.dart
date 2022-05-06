import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/filters/filters_effect.dart';
import 'package:localdaily/pages/filters/filters_status.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/view_model.dart';

import 'filters_status.dart';

class FilterViewModel extends EffectsViewModel<FilterStatus, FilterEffect> {
  late LdRouter _router;
  late ServiceInteractor _interactor;
  FilterViewModel(
    this._router,
    this._interactor,
  ) {
    status = FilterStatus(
      isLoading: false,
      resultGetBanks: ResultGetBanks(
        data: <Bank>[],
        totalItems: 10,
        totalPages: 1,
      ),
      // banks: [],
      selectRange: RangeValues(0, 5),
    );
  }

  Future<void> onInit(
    BuildContext context,
    ConfigurationProvider configurationProvider,
  ) async {
    final Pagination bodyGetBanks = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );
    final bool next = await LdConnection.validateConnection();
    if (next) {
      try {
        await _interactor.getBanks(bodyGetBanks).then((response) {
          final ResultGetBanks? _resultGetBanks = response.result;
          status = status.copyWith(resultGetBanks: _resultGetBanks);
        });
        print('Lista de bancos ${status.resultGetBanks.data[0].description}');
      } catch (e) {
        print('$e');
      }
    } else {
      addEffect(ShowSnackConnetivityEffect('Sin conexión a internet'));
    }
  }

  void getDialogBanks(BuildContext context) {
    final GlobalKey<FormBuilderState> _formKeyBanks =
        GlobalKey<FormBuilderState>();

    final Widget customWidget = FormBuilderCheckboxGroup(
      key: _formKeyBanks,
      name: 'listBanks',
      initialValue: status.banks,
      activeColor: LdColors.orangePrimary,
      // onReset: () {
      //   _formKeyBanks.currentState?.reset();
      // },
      onChanged: (banks) {
        status = status.copyWith(
            banks: banks?.map((bank) => bank.toString()).toList());
      },
      options: status.resultGetBanks.data
          .map(
            (data) => FormBuilderFieldOption(
              child: Text(data.description),
              value: data.id,
            ),
          )
          .toList(growable: false),
    );

    return LdDialog.buildWidgetAlertDialog(
      context,
      customWidget: customWidget,
      title: 'Selecciona las entidades',
    );
  }

  String getDateExpiry(int index) {
    String resp = '';
    switch (index) {
      case 0:
        DateTime init = DateTime.now();
        resp =
            '${init.toUtc().millisecondsSinceEpoch}, ${init.add(Duration(hours: 24)).toUtc().millisecondsSinceEpoch}';
        break;
      case 1:
        DateTime init = DateTime.now();
        resp =
            '${init.add(Duration(hours: 24)).toUtc().millisecondsSinceEpoch}, ${init.add(Duration(days: 8)).toUtc().millisecondsSinceEpoch}';
        break;
      case 2:
        DateTime init = DateTime.now();
        resp =
            '${init.add(Duration(hours: 72)).toUtc().millisecondsSinceEpoch}, ${init.add(Duration(days: 8)).toUtc().millisecondsSinceEpoch}';
        break;
      default:
    }
    return '[$resp]';
    //return '[1651867267004, 1652561463000]';
    //[1651867267004, 1652561463000]
  }

  String getDateExpiryOper(int index) {
    String resp = '';
    switch (index) {
      case 0:
        DateTime init = DateTime.now();
        resp =
            '${init.toUtc().millisecondsSinceEpoch}, ${init.add(Duration(hours: 4)).toUtc().millisecondsSinceEpoch}';
        break;
      case 1:
        DateTime init = DateTime.now();
        resp =
            '${init.add(Duration(hours: 4)).toUtc().millisecondsSinceEpoch}, ${init.add(Duration(hours: 8)).toUtc().millisecondsSinceEpoch}';
        break;
      case 2:
        DateTime init = DateTime.now();
        resp =
            '${init.add(Duration(hours: 8)).toUtc().millisecondsSinceEpoch}, ${init.add(Duration(days: 8)).toUtc().millisecondsSinceEpoch}';
        break;
      default:
    }
    return '[$resp]';
  }

  void setRange(int index) {
    status = status.copyWith(range: index);
    print(status.range);
    print(index);
  }

  void setStatus(int index) {
    status = status.copyWith(status: index);
    print(status.status);
    print(index);
  }

  void setDateExpiry(int index) {
    status = status.copyWith(dateExpiry: index);
    print(status.dateExpiry);
    print(index);
  }

  void setRangeSlider(RangeValues rangeValues) {
    status = status.copyWith(selectRange: rangeValues);
    print(status.dateExpiry);
    print(rangeValues);
  }

  void goToHome(BuildContext context) {
    _router.goHome(context);
  }

  void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
