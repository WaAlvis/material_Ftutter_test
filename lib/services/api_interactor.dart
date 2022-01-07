import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/local_daily_gateway_service.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offerts/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offerts/offert/body_offert.dart';
import 'package:localdaily/services/models/create_offerts/offert/result_create_offert.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/result_home.dart';
import 'package:localdaily/services/models/login/body_login.dart';
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
      Pagination bodyGetDocuments) async {
    final ResponseData<ResultGetDocsType> response =
        await locator<LocalDailyGatewayService>().getDocsType(bodyGetDocuments);

    return response;
  }

  Future<ResponseData<ResultGetBanks>> getBanks(Pagination bodyGetBanks) async {
    final ResponseData<ResultGetBanks> response =
        await locator<LocalDailyGatewayService>().getBanks(bodyGetBanks);

    return response;
  }

  Future<ResponseData<ResultCreateOffert>> createOffert(
      BodyOffert bodyOffert) async {
    final ResponseData<ResultCreateOffert> response =
        await locator<LocalDailyGatewayService>().createOffert(bodyOffert);
    return response;
  }

  Future<ResponseData<ResultLogin>> postLogin(BodyLogin bodyLogin) async {
    final ResponseData<ResultLogin> response =
        await locator<LocalDailyGatewayService>().loginUser(bodyLogin);

    return response;
  }

  Future<ResponseData<ResultPinEmail>> sendPinValidateEmail(
      BodyPinEmail bodyPin,
  ) async {
    final ResponseData<ResultPinEmail> response =
        await locator<LocalDailyGatewayService>().sendPinEmail(bodyPin);
    return response;
  }
  Future<ResponseData<ResultValidatePin>> validatePin(
      BodyValidatePin bodyValidatePin,
      ) async {
    final ResponseData<ResultValidatePin> response =
    await locator<LocalDailyGatewayService>().validatePin(bodyValidatePin);
    return response;
  }

  Future<ResponseData<ResultHome>> postGetHomeBuyerSellers(
      BodyHome bodyHome) async {
    final ResponseData<ResultHome> response =
        await locator<LocalDailyGatewayService>().getAdvertismentHome(bodyHome);

    return response;
  }

  Future<ResponseData<ResultRegister>> postRegisterUser(
      BodyRegisterDataUser bodyRegisterUser) async {
    final ResponseData<ResultRegister> response =
        await locator<LocalDailyGatewayService>()
            .registerUser(bodyRegisterUser);

    return response;
  }
}
