import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/identity_api_service.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/response_login.dart';
import 'package:localdaily/services/models/registerDataUser/body_register_data_user.dart';
import 'package:localdaily/services/models/registerDataUser/response_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/services/web_admin_api_service.dart';

class ServiceInteractor {

  Future<ResponseData<ResponseLogin>> postLogin(BodyLogin bodyLogin) async {
    final  ResponseData<ResponseLogin> response =
      await locator<IdentityApiService>().login(bodyLogin);

    return response;
  }

  Future<ResponseData<ResponseRegister>> postRegisterUser(BodyRegisterDataUser bodyRegisterUser) async {
    final  ResponseData<ResponseRegister> response =
      await locator<WebAdminApiService>().registerUser( bodyRegisterUser);

    return response;
  }
}