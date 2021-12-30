import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'register_status.dart';

class RegisterViewModel extends ViewModel<RegisterStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  List<int> bytes = utf8.encode('woolha');

  RegisterViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = RegisterStatus(
      indexStep: 1,
      isLoading: false,
      isError: false,
      emailRegister: '',
      dateBirthCtrl: TextEditingController(),
    );
  }

  String? validatorEmail(BuildContext context, String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo obligatorio';
      } else if (!isEmail(email)) {
        return '* Debe ser un correo';
      }
      return null;
    }
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  // void goHome(BuildContext context) {
  //   LdConnection.validateConnection().then((bool value) {
  //     if (value) {
  //       _route.goHome(context);
  //     } else {
  //       // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
  //     }
  //   });
  // }

  void setDateBirth(BuildContext context){
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime:
        DateTime.now().subtract(const Duration(days: 36500)),
        maxTime:
        DateTime.now().subtract(const Duration(days: 6570)),
        onChanged: (DateTime date) {
          print('change $date');
        }, onConfirm: (DateTime date) {
          final String dateT = date.toLocal().toString().split(' ').first;
          status.dateBirthCtrl.text = dateT;

          print('confirm ${date.toUtc()}');
          print('confirm ${status.dateBirthCtrl.text}');
        },
        currentTime:
        DateTime.now().subtract(const Duration(days: 10500)),
        locale: LocaleType.es,);
  }
  void goValidateEmail(BuildContext context, String email) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        status = status.copyWith(emailRegister: email, indexStep: 2);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goRegisterPersonalData(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        status = status.copyWith(indexStep: 3);

        // _route.goPersonalInfoRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  Future<void> registerUser(
    BuildContext context, {
    required TextEditingController nickNameCtrl,
    required TextEditingController firstNameCtrl,
    required TextEditingController firstLastNameCtrl,
    required TextEditingController secondNameCtrl,
    required TextEditingController secondLastNameCtrl,
    required TextEditingController phoneCtrl,
    required String emailRegister,
    required TextEditingController dateBirthCtrl,
    required TextEditingController passwordCtrl,
    required TextEditingController confirrmPassCtrl,
    // String email, String password,
  }) async {
    status = status.copyWith(isLoading: true);
    LdConnection.validateConnection().then(
      (bool value) {
        if (value) {
          register(
            context,
            nickName: nickNameCtrl.text,
            firstName: firstNameCtrl.text,
            firstLastName: firstLastNameCtrl.text,
            secondName: secondNameCtrl.text,
            secondLastName: secondLastNameCtrl.text,
            password: passwordCtrl.text,
            phone: phoneCtrl.text,
            email: emailRegister,
            dateBirth: dateBirthCtrl.text,
          );
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    );
  }

  Future<void> register(
    BuildContext context, {
    required String nickName,
    required String firstName,
    required String firstLastName,
    required String secondName,
    required String secondLastName,
    required String password,
    required String phone,
    required String email,
    required String dateBirth,
  }) async {
    status = status.copyWith(isLoading: true);
    print('name: $firstName');
    print('Email: $email');
    final String sha256pass = encrypPass(password).toString();
    print('pass256 $sha256pass');

    final BodyRegisterDataUser bodyRegister = BodyRegisterDataUser(
      nickName: nickName,
      firstName: firstName,
      secondName: secondName,
      firstLastName: firstLastName,
      secondLastName: secondLastName,
      dateBirth: dateBirth,
      email: email,
      phone: phone,
      userTypeId: '9c2f4526-5933-4404-96fc-784a87a7b674',
      password: password,
      isActive: true,
      addressWallet: '',
    );

    _interactor
        .postRegisterUser(bodyRegister)
        .then((ResponseData<ResultRegister> response) {
      print('Register Res: ${response.statusCode} ');
      if (response.isSuccess) {
        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      print('Registro Error As: $err');
      status = status.copyWith(isLoading: false);
    });
  }

  Digest encrypPass(String pass) {
    final List<int> bytes = utf8.encode(pass);
    return sha256.convert(bytes);
  }
}
