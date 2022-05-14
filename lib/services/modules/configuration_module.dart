import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/contact_support/filters.dart';
import 'package:localdaily/services/models/contact_support/support_status/body_support_status.dart';
import 'package:localdaily/services/models/contact_support/support_status/result_support_status.dart';
import 'package:localdaily/services/models/contact_support/support_type/body_support_type.dart';
import 'package:localdaily/services/models/contact_support/support_type/result_support_type.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/result_account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/type_offer/result_type_offer.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';

class ConfigurationModule {
  static Future<void> getBanks(
    ConfigurationProvider configurationProvider,
    ServiceInteractor interactor,
  ) async {
    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );

    try {
      final ResponseData<ResultGetBanks> response =
          await interactor.getBanks(pagination);
      if (!response.isSuccess) {
        throw response.error?.message ?? 'Error en la consulta';
      }
      configurationProvider.setResultBanks(response.result);
    } catch (err) {
      print('Get Banks Error As: $err');
    }
  }

  static Future<void> getDocumentType(
    ConfigurationProvider configurationProvider,
    ServiceInteractor interactor,
  ) async {
    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );

    try {
      final ResponseData<ResultGetDocsType> response =
          await interactor.getDocumentType(pagination);
      if (!response.isSuccess) {
        throw response.error?.message ?? 'Error en la consulta';
      }
      configurationProvider.setResultDocsTypes(response.result);
    } catch (err) {
      print('Get DocType Error As: $err');
    }
  }

  static Future<void> getAccountTypes(
    ConfigurationProvider configurationProvider,
    ServiceInteractor interactor,
  ) async {
    try {
      final ResponseData<ResultAccountType> response =
          await interactor.getAccountType();
      if (!response.isSuccess) {
        throw response.error?.message ?? 'Error en la consulta';
      }
      configurationProvider.setResultAccountTypes(response.result!.entity);
    } catch (err) {
      print('Get AccountType Error As: $err');
    }
  }

  static Future<void> getTypeOffer(
    ConfigurationProvider configurationProvider,
    ServiceInteractor interactor,
  ) async {
    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );

    try {
      final ResponseData<ResultTypeOffer> response =
          await interactor.getTypesAdvertisement(pagination);
      if (!response.isSuccess) {
        throw response.error?.message ?? 'Error en la consulta';
      }
      configurationProvider.setResultTypeOffer(response.result);
    } catch (err) {
      print('Get TypeOffer Error As: $err');
    }
  }

  static Future<void> getSupportStatus(
    ConfigurationProvider configurationProvider,
    ServiceInteractor interactor,
  ) async {
    final Filters filters = Filters(id: '', code: '', description: '');
    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );
    final BodySupportStatus body = BodySupportStatus(
      filters: filters,
      pagination: pagination,
    );

    try {
      final ResponseData<ResultSupportStatus> response =
          await interactor.getSupportStatus(body);
      if (!response.isSuccess) {
        throw response.error?.message ?? 'Error en la consulta';
      }
      configurationProvider.setResultSupportStatus(response.result);
    } catch (err) {
      print('Get TypeOffer Error As: $err');
    }
  }

  static Future<void> getSupportType(
    ConfigurationProvider configurationProvider,
    ServiceInteractor interactor,
  ) async {
    final Filters filters = Filters(id: '', code: '', description: '');
    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );
    final BodySupportType body = BodySupportType(
      filters: filters,
      pagination: pagination,
    );

    try {
      final ResponseData<ResultSupportType> response =
          await interactor.getSupportType(body);
      if (!response.isSuccess) {
        throw response.error?.message ?? 'Error en la consulta';
      }
      configurationProvider.setResultSupportType(response.result);
    } catch (err) {
      print('Get TypeOffer Error As: $err');
    }
  }
}
