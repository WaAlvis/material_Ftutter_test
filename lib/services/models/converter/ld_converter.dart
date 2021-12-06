import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offerts/offert/result_create_offert.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/result_home.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/register/result_register.dart';

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
      if ('$T' == '$ResultCreateOffert?' || T == ResultCreateOffert) {
        return ResultGetBanks.fromJson(json) as T;
      }
    }
    return json as T;
  }

  @override
  Object? toJson(T object) {

    return object;
  }
}
