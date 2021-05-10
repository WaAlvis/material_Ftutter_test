import 'dart:convert';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/register_model.dart';
import 'package:bogota_app/data/model/request/login_request.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/login/login_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_effect.dart';



  class LoginViewModel extends EffectsViewModel<LoginStatus, LoginEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  LoginViewModel(this._route, this._interactor) {
  status = LoginStatus(
  isLoading: true,
  email: '',
  password: '',
  message: ''
  );
  }

  void onInit() async {
    // TODO
  }

  void loginResponse(String email, String password) async {
    LoginRequest params = LoginRequest(email, password);
    print('params');
    print(params.toJson());
    final loginResponse = await _interactor.login(params);

    if (loginResponse is IdtSuccess<RegisterModel?>) {
      print("model login");
      print(loginResponse);
    //  status = status.copyWith(itemsAudioGuide: audioguideResponse.body);
      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    //  addEffect(ShowLoginDialogEffect());
      if (loginResponse.body!.message != null){
        print('entra a if');
        print(loginResponse.body!.message);
      status = status.copyWith(message: loginResponse.body!.message);
      print(status.message);
      addEffect(ShowLoginDialogEffect(status.message));
      }else{
        print('entra a else');
        _route.goHome();
      }



    } else {
      print('se imprime login response');
      print(loginResponse);
      final erroRes = loginResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
      addEffect(ShowLoginDialogEffect(status.message));
    }
    status = status.copyWith(isLoading: false);
  }

  void onChangeScrollController(bool value) {
    addEffect(LoginValueControllerScrollEffect(value));
  }

  void goUserHomePage(String username, String password) {
    print('view model username');
    print(username);
    _route.goUserHome();
  }

}
