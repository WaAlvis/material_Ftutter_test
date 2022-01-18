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
    required this.codePinCtrl,
    required this.heightBody,
    //required this.textTheme,
    Key? key,
  }) : super(key: key);
  final RegisterViewModel viewModel;
  final double heightBody;
  final TextEditingController codePinCtrl;

  //final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    // final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: LdColors.white,
          constraints: BoxConstraints(minHeight: heightBody),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Ingresa el codigo de verificacion enviado\na:',
                        style: textTheme.textBlack,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        viewModel.status.emailRegister,
                        style: textTheme.textBlack
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      PinCodeWidget(
                        viewModel,
                        codePinCtrl: codePinCtrl,
                      ),
                      const SizedBox(
                        height: 90,
                      ),
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
                          style: textTheme.textSmallWhite.copyWith(
                              decoration: TextDecoration.underline,
                              color: LdColors.gray),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Deseas ',
                            style:
                                textTheme.textSmallWhite.copyWith(fontSize: 12),
                          ),
                          InkWell(
                            child: Text(
                              'Reenviar',
                              style: textTheme.textSmallWhite.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: LdColors.orangePrimary,
                                  fontSize: 11),
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Codigo Reenviado!'),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {
                                      // Code to execute.
                                    },
                                  ),
                                ),
                              );
                              viewModel
                                  .sendPinToEmail(viewModel.status.emailRegister);
                            },
                          ),
                          Text(
                            ' el codigo ?',
                            style:
                                textTheme.textSmallWhite.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                PrimaryButtonCustom(
                  'Continuar',
                  onPressed: () => viewModel.validateCodePin(codePinCtrl.text),
                ),
                PrimaryButtonCustom(
                  'pasar sin validar',
                  onPressed: () => viewModel.goNextStep(currentStep: 3),
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
}

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget(
    this.viewModel, {
    Key? key,
    required this.codePinCtrl,
  }) : super(key: key);
  final RegisterViewModel viewModel;
  final TextEditingController codePinCtrl;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: codePinCtrl,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
          selectedColor: LdColors.orangePrimary, activeColor: LdColors.grayText
          // shape: PinCodeFieldShape.box,
          // borderRadius: BorderRadius.circular(5),
          // fieldHeight: 50,
          // fieldWidth: 40,
          // activeFillColor: Colors.white,
          ),
      animationDuration: Duration(milliseconds: 400),
      // backgroundColor: LdColors.whiteGray,
      // enableActiveFill: true,
      // errorAnimationController: errorController,
      // controller: textEditingController,
      // onCompleted: (String pinCode) {
      //   print("Completed");
      //   viewModel.validateCodePin(pinCode);
      // },
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
