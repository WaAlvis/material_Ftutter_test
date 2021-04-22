import 'dart:ffi';



import 'package:bogota_app/data/model/splash_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

import 'splash_status.dart';

class SplashViewModel extends ViewModel<SplashStatus> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  SplashViewModel(this._route, this._interactor) {
    status = SplashStatus();
  }

  void onInit() async {
    // TODO
  }

  void getSplash() async {
    final response = await _interactor.getSplashInteractor();

    if (response is IdtSuccess<SplashModel>) {
      status = status.copyWith(imgSplash: IdtConstants.url_image + response.body.background.toString());
      await Future.delayed(Duration (seconds: 3));
      _route.goLogin();
    } else {
      await Future.delayed(Duration (seconds: 3));
      _route.goLogin();
      final erroRes = response as IdtFailure<FilterError>;
      print(erroRes.message);
      UnimplementedError();
    }
  }
}
