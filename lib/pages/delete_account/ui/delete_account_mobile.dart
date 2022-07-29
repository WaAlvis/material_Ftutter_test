part of 'delete_account_view.dart';

class DeleteAccountMobile extends StatelessWidget {
  const DeleteAccountMobile({
    Key? key,
    required this.keyForm,
    required this.pswDeleteAccountCtrl,

    // required this.scrollCtrl,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  final TextEditingController pswDeleteAccountCtrl;

  @override
  Widget build(BuildContext context) {
    final DeleteAccountViewModel viewModel =
        context.watch<DeleteAccountViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    const double hAppbar = 150;
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                color: LdColors.blackBackground,
                child: AppBarBigger(
                  title: 'Eliminar cuenta',
                  hAppbar: hAppbar,
                  textTheme: textTheme,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                width: size.width,
                constraints: BoxConstraints(minHeight: hBody),
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
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Eliminar Cuenta de usuario',
                              style: textTheme.textBlack.copyWith(
                                // color: LdColors.orangeWarning,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Esta accion eliminara de manera permanente tu cuenta de usuario',
                              style: textTheme.textBlack.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InputTextCustom(
                        'Verificacion de contraseña*',
                        hintText: '8+ digitos',
                        controller: pswDeleteAccountCtrl,
                        onChange: (String psw) {},
                        changeFillWith:
                            !viewModel.status.isCurrentPswFieldEmpty,
                        textInputAction: TextInputAction.next,
                        obscureText: viewModel.status.hidePass,
                        validator: (_) => viewModel.validatorPswNotEmpty(
                          pswDeleteAccountCtrl.text,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => viewModel.hidePsw(),
                          child: Icon(
                            viewModel.status.hidePass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: LdColors.blackBackground,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PrimaryButtonCustom(
                        'Eliminar cuenta',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (keyForm.currentState!.validate()) {
                            viewModel.deleteAccount(
                              context,
                              dataUserProvider,
                              pswDeleteAccountCtrl.text,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
