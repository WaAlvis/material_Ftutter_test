import 'package:dio/dio.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/create_offers/transaction/body_createtransaction.dart';
import 'package:localdaily/services/models/create_offers/type_offer/result_type_offer.dart';
import 'package:localdaily/services/models/detail_offer/body_add_pay_account.dart';
import 'package:localdaily/services/models/detail_offer/body_update_status.dart';
import 'package:localdaily/services/models/detail_offer/result_update_status.dart';
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
import 'package:localdaily/services/models/users/body_updateaddress.dart';
import 'package:retrofit/http.dart';

part 'local_daily_gateway_service.g.dart';

class UrlsApi {
  static const String getAllByFilters =
      '/WebAdmin/Advertisement/GetAllByFilters';
  static const String createUser = '/User/User';
  static const String login = '/Identity/Authentication';
  static const String dataUser = '/User/User/GetById';
  static const String getBanks = '/Configuration/ConfigurationBank/GetData';
  static const String updateStatusAdv = '/WebAdmin/Advertisement/UpdateStatus';
  static const String getDocsType =
      '/Configuration/ConfigurationDocumentType/GetData';
  static const String createOffer = '/WebAdmin/Advertisement';
  static const String sendPinEmail =
      '/NotificationCenter/SendMessageEvent/SendNotificationOtp';
  static const String validateToken =
      '/NotificationCenter/SendMessageEvent/ValidationToken';
  static const String updateAddress = '/User/User/UpdateUserAddressWallet';
  static const String createTransaction =
      '/Transaction/Transaction/CreateTransaction';
  static const String addPayAccount =
      '/WebAdmin/AdvertisementPayAccount/AddPayAccount';
  static const String getTypeAdvertisement =
      '/WebAdmin/TypeAdvertisement/GetAllTypeAdvertisement';
}

///WebAdmin/Advertisement create offer sell buy

@RestApi(baseUrl: 'https://dev-local-indentity.midaily.co')
abstract class LocalDailyGatewayService {
  factory LocalDailyGatewayService(Dio dio, {String baseUrl}) =
      _LocalDailyGatewayService;

  //Login & Register
  @POST(UrlsApi.login)
  Future<ResponseData<ResultLogin>> loginUser(
    @Body() BodyLogin bodyLogin,
  );

  @POST(UrlsApi.sendPinEmail)
  Future<ResponseData<ResultPinEmail>> sendPinEmail(
    @Body() BodyPinEmail bodyPin,
  );

  @POST(UrlsApi.validateToken)
  Future<ResponseData<ResultValidatePin>> validatePin(
    @Body() BodyValidatePin bodyValidatePin,
  );

  @POST(UrlsApi.createUser)
  Future<ResponseData<ResultRegister>> registerUser(
    @Body() BodyRegisterDataUser bodyRegisterDataUser,
  );

  //HOME
  @POST(UrlsApi.getAllByFilters)
  Future<ResponseData<ResultHome>> getAdvertisment(
    @Body() BodyHome bodyHome,
  );

//Data User, Bank, Doc
  @GET(UrlsApi.dataUser)
  Future<ResponseData<ResultDataUser>> getUserId(
    @Query('id') String id,
  );

  @POST(UrlsApi.getBanks)
  Future<ResponseData<ResultGetBanks>> getBanks(
    @Body() Pagination bodyGetBanks,
  );

  @POST(UrlsApi.getDocsType)
  Future<ResponseData<ResultGetDocsType>> getDocsType(
    @Body() Pagination bodyGetDocsType,
  );

  //Offer
  @POST(UrlsApi.createOffer)
  Future<ResponseData<ResultCreateOffer>> createOffer(
    @Body() BodyOffer bodyOffer,
  );

  @PUT(UrlsApi.updateStatusAdv)
  Future<ResponseData<ResultUpdateStatus>> updateStatusAdv(
    @Body() BodyUpdateStatus bodyCreateSmartContract,
  );

  @PUT(UrlsApi.updateAddress)
  Future<ResponseData<dynamic>> updateAddress(
    @Body() BodyUpdateAddress bodyUpdateAddress,
  );

  @POST(UrlsApi.createTransaction)
  Future<ResponseData<dynamic>> createTransaction(
    @Body() BodyCreateTransaction bodyCreateTransaction,
  );

  @POST(UrlsApi.addPayAccount)
  Future<ResponseData<dynamic>> addPayAccount(
    @Body() BodyAddPayAccount body,
  );

  @POST(UrlsApi.getTypeAdvertisement)
  Future<ResponseData<ResultTypeOffer>> getTypeAdvertisement(
    @Body() Pagination body,
  );
}
