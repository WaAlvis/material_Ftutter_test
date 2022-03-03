import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_status.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:open_mail_app/open_mail_app.dart';

class Step2MsjEmail extends StatelessWidget {
  const Step2MsjEmail({
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
                          'Verificación de correo',
                          style: textTheme.textBigWhite
                              .copyWith(color: LdColors.orangePrimary),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Para verificar este correo, debes ingrear el codigo enviado a:',
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
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () => viewModel.continueStep_3ValidatePin(),
                    child: Text(
                      'Continuar',
                      style: textTheme.textSmallWhite.copyWith(
                          decoration: TextDecoration.underline,
                          color: LdColors.white),
                    ),
                  ),
                  const SizedBox(height:20,),
                  // PrimaryButtonCustom(
                  //   'Continuar',
                  //   colorButton: LdColors.whiteGray,
                  //
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
