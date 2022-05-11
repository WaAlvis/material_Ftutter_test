import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/info/ui/info_view.dart';
import 'package:localdaily/pages/recover_psw/recover_psw_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/recover_psw/body_recover_psw.dart';
import 'package:localdaily/services/models/recover_psw/result_recover_psw.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:string_validator/string_validator.dart';

import 'recover_psw_status.dart';

class RecoverPswViewModel
    extends EffectsViewModel<RecoverPswStatus, RecoverPswEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  RecoverPswViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = RecoverPswStatus(
      isLoading: false,
      isError: false,
      isEmailFieldEmpty: true,
    );
  }

  Future<void> onInit({
    bool validateNotification = false,
  }) async {}

  void changeEmail(String email) =>
      status = status.copyWith(isEmailFieldEmpty: email.isEmpty);

  void requestNewPsw(BuildContext context, TextTheme textTheme, String email) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        status = status.copyWith(isLoading: true);
        sendNewPsw(context, textTheme, email);
        // goPageSuccessRecover(context, textTheme, email);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> reSendNewPsw(
          BuildContext context, TextTheme textTheme, String emailUser) =>
      sendNewPsw(context, textTheme, emailUser, again: true);

  Future<void> sendNewPsw(
    BuildContext context,
    TextTheme textTheme,
    String emailUser, {
    bool again = false,
  }) async {
    status = status.copyWith(isLoading: true);

    final BodyRecoverPsw bodyRecoverPsw = BodyRecoverPsw(
      filter: emailUser,
      document: '',
      clientId: 'f160e3d8-aca1-4c5b-a7df-c07a858013cd',
      signature: '',
      codeLang: 'es',
    );

    _interactor
        .requestPsw(bodyRecoverPsw)
        .then((ResponseData<ResultRecoverPsw> response) {
      if (response.isSuccess) {
        addEffect(ShowSuccessSnackbar('Nueva contraseña enviada'));
        if (!again) goPageSuccessRecover(context, textTheme, emailUser);
        status = status.copyWith(isLoading: false);
      } else {
        addEffect(ShowWarningSnackbar('Error en el envio'));
        status = status.copyWith(isError: true, isLoading: false);
      }
    }).catchError((err) {
      addEffect(ShowErrorSnackbar('Error en el servicio**'));
      print('NewPsw Error As: ${err}');
    });
  }

  void goPageSuccessRecover(
      BuildContext context, TextTheme textTheme, String emailUser) {
    final InfoViewArguments info = InfoViewArguments(
      // actionBack: () => _route.goRecoverPsw(context),
      actionCaption: 'Abrir correo',
      title: 'Verifica tu correo',
      pageTitle: 'Olvidé mi contraseña',
      // customWidget: ,
      imageType: ImageType.email,
      customWidget: reSendRecoverTetButton(context, textTheme, emailUser),
      description:
          'Ingresa nuevamente a tu cuenta con la clave temporal que hemos enviado a:',
      onAction: () async {
        await openEmail(context);
        _route.goLogin(context);
      },
    );
    _route.goInfoView(context, info);
  }

  Widget reSendRecoverTetButton(
      BuildContext context, TextTheme textTheme, String emailUser) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Text(
          emailUser,
          style: textTheme.textWhite.copyWith(fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () => reSendNewPsw(context, textTheme, emailUser),
          child: Text('Reenviar al correo',
              style: textTheme.textSmallWhite.copyWith(
                decoration: TextDecoration.underline,
                color: LdColors.gray,
              )),
        ),
      ],
    );
  }

  String? validatorEmail(String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo necesario';
      } else if (!isEmail(email)) {
        return '* Debe ser un correo';
      }
      return null;
    }
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Abrir App de email',
          ),
          content: const Text(
            'No se encontraron Aplicaciones instaladas',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<dynamic> openEmail(BuildContext context) async {
    final OpenMailAppResult result = await OpenMailApp.openMailApp();
    if (!result.didOpen && !result.canOpen) {
      showNoMailAppsDialog(context);
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            mailApps: result.options,
          );
        },
      );
    }
  }
}
