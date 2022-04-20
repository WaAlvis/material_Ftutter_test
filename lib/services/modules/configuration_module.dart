import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
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
}
