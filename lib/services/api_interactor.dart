import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/local_daily_gateway_service.dart';
import 'package:localdaily/services/models/cancel_oper.dart';
import 'package:localdaily/services/models/change_psw/body_change_psw.dart';
import 'package:localdaily/services/models/change_psw/result_change_psw.dart';
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
import 'package:localdaily/services/models/update_data_user/body_new_data_user.dart';
import 'package:localdaily/services/models/update_data_user/result_change_data_user.dart';
import 'package:localdaily/services/models/users/body_updateaddress.dart';

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
      //no arrojo errores
      BodyOffer bodyOffer,
      String headers) async {
    final ResponseData<ResultCreateOffer> response =
        await locator<LocalDailyGatewayService>()
            .createOffer(bodyOffer, headers);
    return response;
  }

  Future<ResponseData<ResultUpdateStatus>> reserveOffer(
      BodyUpdateStatus body, String headers) async {
    final ResponseData<ResultUpdateStatus> response =
        await locator<LocalDailyGatewayService>()
            .updateStatusAdv(body, headers);
    return response;
  }

  Future<ResponseData<ResultLogin>> postLogin(BodyLogin bodyLogin) async {
    final ResponseData<ResultLogin> response =
        await locator<LocalDailyGatewayService>().loginUser(bodyLogin);

    return response;
  }

  Future<ResponseData<ResultChangeDataUser>> updateDataUser(
    BodyNewDataUser newDataUser,
    String headers,
  ) async {
    final ResponseData<ResultChangeDataUser> response =
        await locator<LocalDailyGatewayService>()
            .updateDataUser(newDataUser, headers);

    return response;
  }

  Future<ResponseData<ResultRecoverPsw>> requestNewPsw(
      BodyRecoverPsw bodyRecoverPsw) async {
    final ResponseData<ResultRecoverPsw> response =
        await locator<LocalDailyGatewayService>().recoverNewPsw(bodyRecoverPsw);

    return response;
  }

  Future<ResponseData<ResultChangePsw>> changePsw(
    BodyChangePsw bodyChangePsw,
    String headers,
  ) async {
    final ResponseData<ResultChangePsw> response =
        await locator<LocalDailyGatewayService>()
            .changePsw(bodyChangePsw, headers);

    return response;
  }

  Future<ResponseData<ResultHistoryOperationsUser>> getHistoryOperationsUser(
    BodyHistoryOperationsUser bodyHistoryOperationsUser,
    String headers,
  ) async {
    final ResponseData<ResultHistoryOperationsUser> response =
        await locator<LocalDailyGatewayService>()
            .getHistoryOperationsUser(bodyHistoryOperationsUser, headers);

    return response;
  }

  Future<ResponseData<ResultInfoUserPublish>> getInfoUserPublish(
    BodyInfoUserPublish bodyInfoUserPublish,
    String headers,
  ) async {
    final ResponseData<ResultInfoUserPublish> response =
        await locator<LocalDailyGatewayService>()
            .getInfoUserPublish(bodyInfoUserPublish, headers);

    return response;
  }

  Future<ResponseData<ResultDataUser>> getUserById(
    String id,
    String headers,
  ) async {
    final ResponseData<ResultDataUser> response =
        await locator<LocalDailyGatewayService>().getUserId(id, headers);

    return response;
  }

  Future<ResponseData<ResultPinEmail>> requestPinValidateEmail(
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

  Future<ResponseData<dynamic>> putUpdateAddress(
    BodyUpdateAddress bodyUpdateAddress,
    String headers,
  ) async {
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>()
            .updateAddress(bodyUpdateAddress, headers);

    return response;
  }

  Future<ResponseData<dynamic>> createTransaction(
    BodyCreateTransaction bodyCreateTransaction,
    String headers,
  ) async {
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>()
            .createTransaction(bodyCreateTransaction, headers);

    return response;
  }

  Future<ResponseData<dynamic>> addPayAccount(
    BodyAddPayAccount body,
    String headers,
  ) async {
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>().addPayAccount(body, headers);

    return response;
  }

  Future<ResponseData<dynamic>> cancelOperation(
    CancelOper body,
    String headers,
  ) async {
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>()
            .cancelOperation(body, headers);

    return response;
  }

  Future<ResponseData<dynamic>> sendAttach({
    required String AdvertisementId,
    required XFile xFile,
    required String UserId,
    required String headers,
  }) async {
    File file = File(xFile.path);
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>().sendAttach(
      AdvertisementId,
      UserId,
      file,
      headers,
    );
    return response;
  }

  Future<ResponseData<ResultTypeOffer>> getTypesAdvertisement(
    Pagination body,
  ) async {
    final ResponseData<ResultTypeOffer> response =
        await locator<LocalDailyGatewayService>().getTypeAdvertisement(body);

    return response;
  }

  Future<ResponseData<dynamic>> confirmPayment(
    ConfirmPayment body,
    String headers,
  ) async {
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>().confirmPayment(body, headers);

    return response;
  }

  Future<ResponseData<ResultDataAdvertisement>> getDetailAdvertisement(
    String id,
    String headers,
  ) async {
    final ResponseData<ResultDataAdvertisement> response =
        await locator<LocalDailyGatewayService>()
            .getDetailAdvertisement(id, headers);
    return response;
  }

  Future<ResponseData<String>> getAttachFile(
    String advertismentID,
    String headers,
  ) async {
    final ResponseData<String> response =
        await locator<LocalDailyGatewayService>()
            .getAttachFile(advertismentID, headers);
    return response;
  }

  Future<ResponseData<ResultAccountType>> getAccountType() async {
    final ResponseData<ResultAccountType> response =
        await locator<LocalDailyGatewayService>().getAccountType();

    return response;
  }

  Future<ResponseData<dynamic>> addRateUser(
    RateUser body,
    String headers,
  ) async {
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>().addRateUser(body, headers);

    return response;
  }

  Future<ResponseData<dynamic>> createContactSupport(
    BodyContactSupport body,
    String headers,
  ) async {
    final ResponseData<dynamic> response =
        await locator<LocalDailyGatewayService>()
            .createSupportCase(body, headers);

    return response;
  }

  Future<ResponseData<ResultNotification>> getNotifications(
    BodyNotifications body,
    String headers,
  ) async {
    final ResponseData<ResultNotification> response =
        await locator<LocalDailyGatewayService>()
            .getNotifications(body, headers);

    return response;
  }

  Future<ResponseData<ResultNotificationCounter>> getNotificationsUnread(
    BodyNotificationCounter body,
    String headers,
  ) async {
    final ResponseData<ResultNotificationCounter> response =
        await locator<LocalDailyGatewayService>()
            .getNotificationsUnread(body, headers);

    return response;
  }

  Future<ResponseData<ResultSupportStatus>> getSupportStatus(
    BodySupportStatus body,
  ) async {
    final ResponseData<ResultSupportStatus> response =
        await locator<LocalDailyGatewayService>().getSupportStatus(body);

    return response;
  }

  Future<ResponseData<ResultSupportType>> getSupportType(
    BodySupportType body,
  ) async {
    final ResponseData<ResultSupportType> response =
        await locator<LocalDailyGatewayService>().getSupportTypes(body);

    return response;
  }

  Future<ResponseData<ResultSupportCases>> getSupportCases(
    BodySupportCases body,
    String headers,
  ) async {
    final ResponseData<ResultSupportCases> response =
        await locator<LocalDailyGatewayService>()
            .getSupportCases(body, headers);

    return response;
  }
}
