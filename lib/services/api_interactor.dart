import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/identity_service.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/reponse/result_home.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/services/web_admin_service.dart';

import 'users_service.dart';

class ServiceInteractor {

  Future<ResponseData<ResultLogin>> postLogin(BodyLogin bodyLogin) async {
    final  ResponseData<ResultLogin> response =
      await locator<IdentityService>().login(bodyLogin);

    return response;
  }

  Future<ResponseData<ResultHome>> postGetHomeBuyerSellers(BodyHome bodyHome) async {
    final  ResponseData<ResultHome> response =
    await locator<WebAdminService>().getAdvertismentHome( bodyHome);

    return response;
  }

  Future<ResponseData<ResultRegister>> postRegisterUser(BodyRegisterDataUser bodyRegisterUser) async {
    final  ResponseData<ResultRegister> response =
    await locator<UsersService>().registerUser( bodyRegisterUser);

    return response;
  }
}