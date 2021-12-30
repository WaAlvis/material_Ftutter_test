import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ThirdStepRegister extends StatelessWidget {
  const ThirdStepRegister({
    required this.viewModel,
    //required this.textTheme,
    Key? key,
  }) : super(key: key);
  final RegisterViewModel viewModel;

  //final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    // final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Container(
        color: LdColors.blackBackground,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Positioned(
              right: 0,
              child: SizedBox(
                // El tamaño depende del tamaño de la pantalla
                width: (size.width) / 4,
                height: (size.width) / 4,
                child: QuarterCircle(
                  circleAlignment: CircleAlignment.bottomRight,
                  color: LdColors.grayLight.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                width: (size.width) * 2 / 4,
                height: (size.width) * 2 / 4,
                child: QuarterCircle(
                  circleAlignment: CircleAlignment.bottomRight,
                  color: LdColors.grayLight.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                width: (size.width) * 3 / 4,
                height: (size.width) * 3 / 4,
                child: QuarterCircle(
                  circleAlignment: CircleAlignment.bottomRight,
                  color: LdColors.grayLight.withOpacity(0.05),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        SvgPicture.asset('lib/assets/images/mail.svg'),
                        const SizedBox(height: 30),
                        Text(
                          'Verifica tu correo',
                          style: textTheme.textBigWhite
                              .copyWith(color: LdColors.orangePrimary),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Confirma tu dirección de correo electrónico haciendo clic en el enlace que hemos enviado a:',
                          textAlign: TextAlign.center,
                          style:
                              textTheme.textSmallWhite.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          viewModel.status.emailRegister,
                          style: textTheme.textWhite
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Reenviar link de correo',
                    style: textTheme.textSmallWhite
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 50),
                  PrimaryButtonCustom('Abrir correo',
                      // onPressed: () => viewModel.goRegisterPersonalData(context),
                      onPressed: () async {
                    // Android: Will open mail app or show native picker.
                    // iOS: Will open mail app if single mail app found.
                    var result = await OpenMailApp.openMailApp();

                    // If no mail apps found, show error
                    if (!result.didOpen && !result.canOpen) {
                      showNoMailAppsDialog(context);

                      // iOS: if multiple mail apps found, show dialog to select.
                      // There is no native intent/default app system in iOS so
                      // you have to do it yourself.
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
                  },),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
