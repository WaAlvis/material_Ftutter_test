part of 'recover_psw_view.dart';

class _RecoverPswWebMobile extends StatelessWidget {
  const _RecoverPswWebMobile({
    Key? key,
    required this.keyForm,
    required this.emailForRecoverCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController emailForRecoverCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final RecoverPswViewModel viewModel = context.watch<RecoverPswViewModel>();
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 120;
    final double hBody = size.height - hAppbar;

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: LdColors.blackBackground,
        appBar: const LdAppbar(
          title: 'Recuperar contraseña',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AppbarCircles(
              hAppbar: hAppbar,
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: hBody,
                ),
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 16,
                  right: 16,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Recuperar contraseña',
                                  style: textTheme.textBigBlack,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  'Ingresa tu correo electrónico, allí recibirás tu nueva contraseña',
                                  style: textTheme.textSmallBlack,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          InputTextCustom(
                            'Correo electronico *',
                            hintText: 'Ingresa correo del usuario',
                            controller: emailForRecoverCtrl,
                            onChange: (String value) =>
                                viewModel.changeEmail(value),
                            changeFillWith: !viewModel.status.isEmailFieldEmpty,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(
                                RegExp(r'[ ]'),
                              ),
                            ],
                            validator: (String? email) =>
                                viewModel.validatorEmail(email),
                          ),
                        ],
                      ),

                      PrimaryButtonCustom(
                        'Enviar',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (keyForm.currentState!.validate()) {
                            viewModel.requestNewPsw(
                                context,textTheme, emailForRecoverCtrl.text,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
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
}
