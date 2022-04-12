import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
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
      print('Get Banks Error As: $err');
    }
  }

  static Future<void> getAccountTypes(
    ConfigurationProvider configurationProvider,
  ) async {
    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: 0,
      itemsPerPage: 0,
    );

    try {
      final ResponseData<ResultGetBanks> response =
          await ServiceInteractor().getBanks(pagination);
      if (!response.isSuccess) {
        throw response.error?.message ?? 'Error en la consulta';
      }
      configurationProvider.setResultBanks(response.result);
    } catch (err) {
      print('Get Banks Error As: $err');
    }
  }
}
