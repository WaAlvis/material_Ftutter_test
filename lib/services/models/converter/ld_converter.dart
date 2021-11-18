import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/login/response_login.dart';
import 'package:localdaily/services/models/register/response_register.dart';

class LdConverter<T> implements JsonConverter<T, Object?> {

  const LdConverter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      if ('$T' == '$ResponseLogin?' || T == ResponseLogin) {
        return ResponseLogin.fromJson(json) as T;
      }
      else if ('$T' == '$ResponseRegister?' || T == ResponseRegister) {
        return ResponseRegister.fromJson(json) as T;
      }
    }
    return json as T;
  }

  @override
  Object? toJson(T object) {

    return object;
  }
}
