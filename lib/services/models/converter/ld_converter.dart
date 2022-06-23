import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/change_psw/result_change_psw.dart';
import 'package:localdaily/services/models/contact_support/support_status/result_support_status.dart';
import 'package:localdaily/services/models/contact_support/support_type/result_support_type.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/result_account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/create_offers/type_offer/result_type_offer.dart';
import 'package:localdaily/services/models/detail_offer/result_update_status.dart';
import 'package:localdaily/services/models/detail_oper_offer/result_get_advertisement.dart';
import 'package:localdaily/services/models/history_operations_user/response/result_history_operations_user.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/info_user_publish/response/result_info_user_publish.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/response/result_login.dart';
import 'package:localdaily/services/models/notifications/counter/result_notification_counter.dart';
import 'package:localdaily/services/models/notifications/result_notification.dart';
import 'package:localdaily/services/models/recover_psw/result_recover_psw.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/register/send_validate/result_pin_email.dart';
import 'package:localdaily/services/models/register/validate_pin/result_validate_pin.dart';
import 'package:localdaily/services/models/support_cases/result_support_cases.dart';
import 'package:localdaily/services/models/update_data_user/result_change_data_user.dart';

class LdConverter<T> implements JsonConverter<T, Object?> {
  const LdConverter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      if ('$T' == '$ResultLogin?' || T == ResultLogin) {
        return ResultLogin.fromJson(json) as T;
      } else if ('$T' == '$ResultRegister?' || T == ResultRegister) {
        return ResultRegister.fromJson(json) as T;
      } else if ('$T' == '$ResultHome?' || T == ResultHome) {
        return ResultHome.fromJson(json) as T;
      } else if ('$T' == '$ResultGetBanks?' || T == ResultGetBanks) {
        return ResultGetBanks.fromJson(json) as T;
      } else if ('$T' == '$ResultGetDocsType?' || T == ResultGetDocsType) {
        return ResultGetDocsType.fromJson(json) as T;
      } else if ('$T' == '$ResultCreateOffer?' || T == ResultCreateOffer) {
        return ResultCreateOffer.fromJson(json) as T;
      } else if ('$T' == '$ResultPinEmail?' || T == ResultPinEmail) {
        return ResultPinEmail.fromJson(json) as T;
      } else if ('$T' == '$ResultValidatePin?' || T == ResultValidatePin) {
        return ResultValidatePin.fromJson(json) as T;
      } else if ('$T' == '$ResultDataUser?' || T == ResultDataUser) {
        return ResultDataUser.fromJson(json) as T;
      } else if ('$T' == '$ResultUpdateStatus?' || T == ResultUpdateStatus) {
        return ResultUpdateStatus.fromJson(json) as T;
      } else if ('$T' == '$ResultTypeOffer?' || T == ResultTypeOffer) {
        return ResultTypeOffer.fromJson(json) as T;
      } else if ('$T' == '$ResultAccountType?' || T == ResultAccountType) {
        return ResultAccountType.fromJson(json) as T;
      } else if ('$T' == '$dynamic?' || T == dynamic) {
        return json as T;
      } else if ('$T' == '$ResultRecoverPsw?' || T == ResultRecoverPsw) {
        return ResultRecoverPsw.fromJson(json) as T;
      } else if ('$T' == '$ResultDataAdvertisement?' ||
          T == ResultDataAdvertisement) {
        return ResultDataAdvertisement.fromJson(json) as T;
      } else if ('$T' == '$ResultHistoryOperationsUser?' ||
          T == ResultHistoryOperationsUser) {
        return ResultHistoryOperationsUser.fromJson(json) as T;
      } else if ('$T' == '$ResultInfoUserPublish?' ||
          T == ResultInfoUserPublish) {
        return ResultInfoUserPublish.fromJson(json) as T;
      } else if ('$T' == '$ResultNotification?' || T == ResultNotification) {
        return ResultNotification.fromJson(json) as T;
      } else if ('$T' == '$ResultNotificationCounter?' ||
          T == ResultNotificationCounter) {
        return ResultNotificationCounter.fromJson(json) as T;
      } else if ('$T' == '$ResultSupportStatus?' || T == ResultSupportStatus) {
        return ResultSupportStatus.fromJson(json) as T;
      } else if ('$T' == '$ResultSupportType?' || T == ResultSupportType) {
        return ResultSupportType.fromJson(json) as T;
      } else if ('$T' == '$ResultSupportCases?' || T == ResultSupportCases) {
        return ResultSupportCases.fromJson(json) as T;
      } else if ('$T' == '$ResultChangePsw?' || T == ResultChangePsw) {
        return ResultChangePsw.fromJson(json) as T;
      }else if ('$T' == '$ResultChangeDataUser?' || T == ResultChangeDataUser) {
        return ResultChangeDataUser.fromJson(json) as T;
      }
    }
    return json as T;
  }

  @override
  Object? toJson(T object) {
    return object;
  }
}
