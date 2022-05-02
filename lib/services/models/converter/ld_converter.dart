import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/attach_file/result_get_attach_file.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/result_account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/create_offers/type_offer/result_type_offer.dart';
import 'package:localdaily/services/models/detail_offer/result_update_status.dart';
import 'package:localdaily/services/models/detail_oper_offer/result_get_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/recover_psw/result_recover_psw.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/register/send_validate/result_pin_email.dart';
import 'package:localdaily/services/models/register/validate_pin/result_validate_pin.dart';

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
      }
    }
    return json as T;
  }

  @override
  Object? toJson(T object) {
    return object;
  }
}
