import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/detail_offer/result_create_smart_contract.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/result_login.dart';
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
      }
      else if ('$T' == '$ResultRegister?' || T == ResultRegister) {
        return ResultRegister.fromJson(json) as T;
      }
      if ('$T' == '$ResultHome?' || T == ResultHome) {
        return ResultHome.fromJson(json) as T;
      }
      if ('$T' == '$ResultGetBanks?' || T == ResultGetBanks) {
        return ResultGetBanks.fromJson(json) as T;
      }
      if ('$T' == '$ResultGetDocsType?' || T == ResultGetDocsType) {
        return ResultGetDocsType.fromJson(json) as T;
      }
      if ('$T' == '$ResultCreateOffer?' || T == ResultCreateOffer) {
        return ResultCreateOffer.fromJson(json) as T;
      }
      if ('$T' == '$ResultPinEmail?' || T == ResultPinEmail) {
        return ResultPinEmail.fromJson(json) as T;
      }
      if ('$T' == '$ResultValidatePin?' || T == ResultValidatePin) {
        return ResultValidatePin.fromJson(json) as T;
      }
      if ('$T' == '$ResultDataUser?' || T == ResultDataUser) {
        return ResultDataUser.fromJson(json) as T;
      }
      if ('$T' == '$ResultCreateSmartContract?' || T == ResultCreateSmartContract) {
        return ResultCreateSmartContract.fromJson(json) as T;
      }
    }
    return json as T;
  }

  @override
  Object? toJson(T object) {

    return object;
  }
}