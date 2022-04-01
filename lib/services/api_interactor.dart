import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/local_daily_gateway_service.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/detail_offer/advertisement.dart';
import 'package:localdaily/services/models/detail_offer/body_create_smart_contract.dart';
import 'package:localdaily/services/models/detail_offer/result_create_smart_contract.dart';
import 'package:localdaily/services/models/detail_offer/smart_contract.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/register/send_validate/body_pin_email.dart';
import 'package:localdaily/services/models/register/send_validate/result_pin_email.dart';
import 'package:localdaily/services/models/register/validate_pin/body_validate_pin.dart';
import 'package:localdaily/services/models/register/validate_pin/result_validate_pin.dart';
import 'package:localdaily/services/models/response_data.dart';

class ServiceInteractor {
  Future<ResponseData<ResultGetDocsType>> getDocumentType(
    Pagination bodyGetDocuments,
  ) async {
    final ResponseData<ResultGetDocsType> response =
        await locator<LocalDailyGatewayService>().getDocsType(bodyGetDocuments);

    return response;
  }

  Future<ResponseData<ResultGetBanks>> getBanks(Pagination bodyGetBanks) async {
    final ResponseData<ResultGetBanks> response =
        await locator<LocalDailyGatewayService>().getBanks(bodyGetBanks);

    return response;
  }

  Future<ResponseData<ResultCreateOffer>> createOffer(
    BodyOffer bodyOffer,
  ) async {
    final ResponseData<ResultCreateOffer> response =
        await locator<LocalDailyGatewayService>().createOffer(bodyOffer);
    return response;
  }

  Future<ResponseData<ResultCreateSmartContract>> createSmartContract(
    BodyCreateSmartContract bodyCreateSmartContract,
  ) async {
    final ResponseData<ResultCreateSmartContract> response =
        await locator<LocalDailyGatewayService>()
            .createSmartContract(bodyCreateSmartContract);
    return response;
  }

  Future<ResponseData<ResultLogin>> postLogin(BodyLogin bodyLogin) async {
    final ResponseData<ResultLogin> response =
        await locator<LocalDailyGatewayService>().loginUser(bodyLogin);

    return response;
  }

  Future<ResponseData<ResultDataUser>> getUserById(String id) async {
    final ResponseData<ResultDataUser> response =
        await locator<LocalDailyGatewayService>().getUserId(id);

    return response;
  }

  Future<ResponseData<ResultPinEmail>> requestPinValidateEmail(
    BodyPinEmail bodyPin,
  ) async {
    final ResponseData<ResultPinEmail> response =
        await locator<LocalDailyGatewayService>().sendPinEmail(bodyPin);
    print(response.statusCode);
    return response;
  }

  Future<ResponseData<ResultValidatePin>> validatePin(
    BodyValidatePin bodyValidatePin,
  ) async {
    final ResponseData<ResultValidatePin> response =
        await locator<LocalDailyGatewayService>().validatePin(bodyValidatePin);
    print(response.result);
    return response;
  }

  Future<ResponseData<ResultHome>> postGetAdvertisementByFilters(
    BodyHome bodyHome,
  ) async {
    final ResponseData<ResultHome> response =
        await locator<LocalDailyGatewayService>().getAdvertisment(bodyHome);

    return response;
  }

  Future<ResponseData<ResultRegister>> postRegisterUser(
    BodyRegisterDataUser bodyRegisterUser,
  ) async {
    final ResponseData<ResultRegister> response =
        await locator<LocalDailyGatewayService>()
            .registerUser(bodyRegisterUser);

    return response;
  }
}
