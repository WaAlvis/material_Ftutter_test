import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localdaily/services/models/attach_file/result_get_attach_file.dart';
import 'package:localdaily/services/models/cancel_oper.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/result_account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/create_offers/transaction/body_createtransaction.dart';
import 'package:localdaily/services/models/create_offers/type_offer/result_type_offer.dart';
import 'package:localdaily/services/models/detail_offer/body_add_pay_account.dart';
import 'package:localdaily/services/models/detail_offer/body_update_status.dart';
import 'package:localdaily/services/models/detail_offer/result_update_status.dart';
import 'package:localdaily/services/models/detail_oper_offer/confirm_payment/confirm_payment.dart';
import 'package:localdaily/services/models/detail_oper_offer/rate_user/rate_user.dart';
import 'package:localdaily/services/models/detail_oper_offer/result_get_advertisement.dart';
import 'package:localdaily/services/models/history_operations_user/body_history_operations_user.dart';
import 'package:localdaily/services/models/history_operations_user/response/result_history_operations_user.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/info_user_publish/body_info_user_publish.dart';
import 'package:localdaily/services/models/info_user_publish/response/result_info_user_publish.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/recover_psw/body_recover_psw.dart';
import 'package:localdaily/services/models/recover_psw/result_recover_psw.dart';
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
  static const String recoverPassword = '/Identity/GetRecoverPassword';
  static const String dataUser = '/User/User/GetById';
  static const String getBanks = '/Configuration/ConfigurationBank/GetData';
  static const String updateStatusAdv = '/WebAdmin/Advertisement/UpdateStatus';
  static const String getHistoryOperationsUser =
      '/WebAdmin/Advertisement/GetHistoryAvertisementUser';
  static const String getDocsType =
      '/Configuration/ConfigurationDocumentType/GetData';
  static const String createOffer = '/WebAdmin/Advertisement';
  static const String sendPinEmail =
      '/NotificationCenter/SendMessageEvent/SendNotificationOtp';
  static const String validateToken =
      '/NotificationCenter/SendMessageEvent/ValidationToken';
  static const String releaseToken =
      '/Transaction/DistributionOptions/ReleaseToken';
  static const String updateAddress = '/User/User/UpdateUserAddressWallet';
  static const String createTransaction =
      '/Transaction/Transaction/CreateTransaction';
  static const String addPayAccount =
      '/WebAdmin/AdvertisementPayAccount/AddPayAccount';
  static const String sendAttach =
      '/AttachDocuments/AttachDocument/AttachDocument';
  static const String getTypeAdvertisement =
      '/WebAdmin/TypeAdvertisement/GetAllTypeAdvertisement';

  static const String getDetailAdvertisement = '/WebAdmin/Advertisement/id';
  static const String getAccountType =
      '/Configuration/ConfigurationAccountType/GetData';
  static const String getAttachFile =
      '/AttachDocuments/AttachDocument/GetDocumentAdvertisement';

  static const String addRateUser = '/User/UserInfoAdditional/RateUser';
  static const String cancelOperation =
      '/Transaction/DistributionOptions/CancelOperation';
  static const String getInfoUserPublish = '/User/UserInfoAdditional';
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

  //Login & Register
  @POST(UrlsApi.recoverPassword)
  Future<ResponseData<ResultRecoverPsw>> recoverPsw(
    @Body() BodyRecoverPsw bodyRecoverPsw,
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

  @POST(UrlsApi.getHistoryOperationsUser)
  Future<ResponseData<ResultHistoryOperationsUser>> getHistoryOperationsUser(
    @Body() BodyHistoryOperationsUser bodyHistoryOperationsUser,
  );

  @POST(UrlsApi.getInfoUserPublish)
  Future<ResponseData<ResultInfoUserPublish>> getInfoUserPublish(
    @Body() BodyInfoUserPublish bodyInfoUserPublish,
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

  @POST(UrlsApi.cancelOperation)
  Future<ResponseData<dynamic>> cancelOperation(
    @Body() CancelOper body,
  );

// Attach file
  @POST(UrlsApi.sendAttach)
  Future<ResponseData<dynamic>> sendAttach(
    @Part() String AdvertisementId,
    @Part() String UserId,
    @Part() File File,
  );

  //Get
  @GET(UrlsApi.getDetailAdvertisement)
  Future<ResponseData<ResultDataAdvertisement>> getDetailAdvertisement(
    @Query('id') String id,
  );
  //Get
  @GET(UrlsApi.getAttachFile)
  Future<ResponseData<String>> getAttachFile(
    @Query('advertismentID') String advertismentID,
  );

  @POST(UrlsApi.getTypeAdvertisement)
  Future<ResponseData<ResultTypeOffer>> getTypeAdvertisement(
    @Body() Pagination body,
  );

  @POST(UrlsApi.releaseToken)
  Future<ResponseData<dynamic>> confirmPayment(
    @Body() ConfirmPayment body,
  );

  @POST(UrlsApi.addRateUser)
  Future<ResponseData<dynamic>> addRateUser(
    @Body() RateUser body,
  );

  @POST(UrlsApi.getAccountType)
  Future<ResponseData<ResultAccountType>> getAccountType();
}
