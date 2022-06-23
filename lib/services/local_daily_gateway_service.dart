import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:localdaily/services/models/change_psw/body_change_psw.dart';
import 'package:localdaily/services/models/change_psw/result_change_psw.dart';
import 'package:localdaily/services/models/cancel_oper.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/services/models/contact_support/support_status/body_support_status.dart';
import 'package:localdaily/services/models/contact_support/support_status/result_support_status.dart';
import 'package:localdaily/services/models/contact_support/support_type/body_support_type.dart';
import 'package:localdaily/services/models/contact_support/support_type/result_support_type.dart';
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
import 'package:localdaily/services/models/login/response/result_login.dart';
import 'package:localdaily/services/models/notifications/body_notifications.dart';
import 'package:localdaily/services/models/notifications/counter/body_notification_counter.dart';
import 'package:localdaily/services/models/notifications/counter/result_notification_counter.dart';
import 'package:localdaily/services/models/notifications/result_notification.dart';
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
import 'package:localdaily/services/models/support_cases/body_support_cases.dart';
import 'package:localdaily/services/models/support_cases/result_support_cases.dart';
import 'package:localdaily/services/models/update_data_user/result_change_data_user.dart';
import 'package:localdaily/services/models/users/body_updateaddress.dart';
import 'package:retrofit/http.dart';

import 'models/update_data_user/body_new_data_user.dart';

part 'local_daily_gateway_service.g.dart';

class UrlsApi {
  static const String getAllByFilters =
      '/WebAdmin/Advertisement/GetAllByFilters';
  static const String createUser = '/User/User';
  static const String login = '/Identity/Authentication';
  static const String recoverPassword = '/Identity/GetRecoverPassword';
  static const String changePassword = '/Identity/ChangePassword';
  static const String dataUser = '/User/User/GetById';
  static const String getBanks = '/Configuration/ConfigurationBank/GetData';
  static const String updateStatusAdv = '/WebAdmin/Advertisement/UpdateStatus';
  static const String updateDataUser = '/User/User/ChangeUserNickname';
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
  static const String createSupportCase = '/WebAdmin/SupportCase';
  static const String getNotifications =
      '/WebAdmin/Notification/GetNotificationByUserId';
  static const String getNotificationsUnread =
      '/WebAdmin/Notification/GetCountNotificationUnread';
  static const String getSupportStatus = '/WebAdmin/SupportStatus';
  static const String getSupportTypes = '/WebAdmin/SupportType';
  static const String getSupportCases = '/WebAdmin/SupportCase/GetSupport';
}

///WebAdmin/Advertisement create offer sell buy

@RestApi(baseUrl: 'https://dev-local-indentity.midaily.co') // Dev
// @RestApi(baseUrl: 'https://local-gwmobile.stglocal.consulting') // Stangin
// @Header('common-header: xx')
abstract class LocalDailyGatewayService {
  factory LocalDailyGatewayService(
    Dio dio, {
    String baseUrl,
  }) = _LocalDailyGatewayService;

  //Login & Register
  @POST(UrlsApi.login) // No necesita token
  Future<ResponseData<ResultLogin>> loginUser(
    @Body() BodyLogin bodyLogin,
  );

  //Recover Psw
  @POST(UrlsApi.recoverPassword)
  Future<ResponseData<ResultRecoverPsw>> recoverNewPsw(
    @Body() BodyRecoverPsw bodyRecoverPsw,
    // @Header('Authorization') String headers,
  );

  //Change Psw
  @POST(UrlsApi.changePassword)
  Future<ResponseData<ResultChangePsw>> changePsw(
    @Body() BodyChangePsw bodyChangePsw,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.sendPinEmail)
  Future<ResponseData<ResultPinEmail>> sendPinEmail(
    @Body() BodyPinEmail bodyPin,
    @Header('Authorization') String headers,
  );

  //Validate OTP
  @POST(UrlsApi.validateToken)
  Future<ResponseData<ResultValidatePin>> validatePin(
    @Body() BodyValidatePin bodyValidatePin,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.createUser)
  Future<ResponseData<ResultRegister>> registerUser(
    @Body() BodyRegisterDataUser bodyRegisterDataUser,
    @Header('Authorization') String headers,
  );

  //HOME
  @POST(UrlsApi.getAllByFilters) // No necesita token
  Future<ResponseData<ResultHome>> getAdvertisment(
    @Body() BodyHome bodyHome,
  );

//Data User, Bank, Doc
  @GET(UrlsApi.dataUser)
  Future<ResponseData<ResultDataUser>> getUserId(
    @Query('id') String id,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.getBanks) // no necesita token
  Future<ResponseData<ResultGetBanks>> getBanks(
    @Body() Pagination bodyGetBanks,
  );

  @POST(UrlsApi.getDocsType) // No necesita token
  Future<ResponseData<ResultGetDocsType>> getDocsType(
    @Body() Pagination bodyGetDocsType,
  );

  @POST(UrlsApi.getHistoryOperationsUser)
  Future<ResponseData<ResultHistoryOperationsUser>> getHistoryOperationsUser(
    @Body() BodyHistoryOperationsUser bodyHistoryOperationsUser,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.getInfoUserPublish)
  Future<ResponseData<ResultInfoUserPublish>> getInfoUserPublish(
    @Body() BodyInfoUserPublish bodyInfoUserPublish,
    @Header('Authorization') String headers,
  );

  //Offer
  @POST(UrlsApi.createOffer)
  Future<ResponseData<ResultCreateOffer>> createOffer(
    @Body() BodyOffer bodyOffer,
    @Header('Authorization') String headers,
  );

  @PUT(UrlsApi.updateStatusAdv)
  Future<ResponseData<ResultUpdateStatus>> updateStatusAdv(
    @Body() BodyUpdateStatus bodyCreateSmartContract,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.updateDataUser)
  Future<ResponseData<ResultChangeDataUser>> updateDataUser(
      @Body() BodyNewDataUser newDataUser,
      @Header('Authorization') String headers,
      );

  @PUT(UrlsApi.updateAddress)
  Future<ResponseData<dynamic>> updateAddress(
    @Body() BodyUpdateAddress bodyUpdateAddress,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.createTransaction)
  Future<ResponseData<dynamic>> createTransaction(
    @Body() BodyCreateTransaction bodyCreateTransaction,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.addPayAccount)
  Future<ResponseData<dynamic>> addPayAccount(
    @Body() BodyAddPayAccount body,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.cancelOperation)
  Future<ResponseData<dynamic>> cancelOperation(
    @Body() CancelOper body,
    @Header('Authorization') String headers,
  );

// Attach file
  @POST(UrlsApi.sendAttach)
  Future<ResponseData<dynamic>> sendAttach(
    @Part() String AdvertisementId,
    @Part() String UserId,
    @Part() File File,
    @Header('Authorization') String headers,
  );

  //Get
  @GET(UrlsApi.getDetailAdvertisement)
  Future<ResponseData<ResultDataAdvertisement>> getDetailAdvertisement(
    @Query('id') String id,
    @Header('Authorization') String headers,
  );
  //Get
  @GET(UrlsApi.getAttachFile)
  Future<ResponseData<String>> getAttachFile(
    @Query('advertismentID') String advertismentID,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.getTypeAdvertisement) //No necesita token
  Future<ResponseData<ResultTypeOffer>> getTypeAdvertisement(
    @Body() Pagination body,
  );

  @POST(UrlsApi.releaseToken)
  Future<ResponseData<dynamic>> confirmPayment(
    @Body() ConfirmPayment body,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.addRateUser)
  Future<ResponseData<dynamic>> addRateUser(
    @Body() RateUser body,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.getAccountType) // No necesita token
  Future<ResponseData<ResultAccountType>> getAccountType();

  @POST(UrlsApi.createSupportCase)
  Future<ResponseData<dynamic>> createSupportCase(
    @Body() BodyContactSupport body,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.getNotifications)
  Future<ResponseData<ResultNotification>> getNotifications(
    @Body() BodyNotifications body,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.getNotificationsUnread)
  Future<ResponseData<ResultNotificationCounter>> getNotificationsUnread(
    @Body() BodyNotificationCounter body,
    @Header('Authorization') String headers,
  );

  @POST(UrlsApi.getSupportStatus) // No necesita token
  Future<ResponseData<ResultSupportStatus>> getSupportStatus(
    @Body() BodySupportStatus body,
  );

  @POST(UrlsApi.getSupportTypes) // No necesita token
  Future<ResponseData<ResultSupportType>> getSupportTypes(
    @Body() BodySupportType body,
  );

  @POST(UrlsApi.getSupportCases)
  Future<ResponseData<ResultSupportCases>> getSupportCases(
    @Body() BodySupportCases body,
    @Header('Authorization') String headers,
  );
}
