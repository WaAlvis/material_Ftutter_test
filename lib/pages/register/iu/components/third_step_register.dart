import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
    final double hAppbar = size.height * 0.26;
    final double hBody = size.height - hAppbar;

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: LdColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                  ),
                  child: Column(

                    children: <Widget>[
                      Text(
                        'Ingresa el codigo de verificacion.',
                        style: textTheme.textBlack,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const PinCodeWidget(),
                      TextButton(
                        onPressed: () async {
                          final OpenMailAppResult result =
                              await OpenMailApp.openMailApp();

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
                        },
                        child: Text(
                          'Abrir correo',
                          style: textTheme.textSmallWhite
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Reenviar link de correo',
                        style: textTheme.textSmallWhite
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                PrimaryButtonCustom(
                  'Continuar',
                  onPressed: () =>
                      viewModel.goNextStep(context, currentStep: 3),
                ),
              ],
            ),
          ),
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

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      // pinTheme: PinTheme(
      //   shape: PinCodeFieldShape.box,
      //   borderRadius: BorderRadius.circular(5),
      //   fieldHeight: 50,
      //   fieldWidth: 40,
      //   activeFillColor: Colors.white,
      // ),
      animationDuration: Duration(milliseconds: 300),
      // backgroundColor: LdColors.whiteGray,
      // enableActiveFill: true,
      // errorAnimationController: errorController,
      // controller: textEditingController,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
        // setState(() {
        //   currentText = value;
        // });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: context,
    );
  }
}
