part of 'settings_update_view.dart';

class SettingsUpdateMobile extends StatelessWidget {
  const SettingsUpdateMobile(
    this.nickNameCtrl, {
    Key? key,
    required this.keyForm,

    // required this.scrollCtrl,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  final TextEditingController nickNameCtrl;

  @override
  Widget build(BuildContext context) {
    final SettingsUpdateViewModel viewModel =
        context.watch<SettingsUpdateViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 150;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBarBigger(
              title: 'Actualizar informacion',
              hAppbar: hAppbar,
              textTheme: textTheme,
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
                            'Cambiar Informacion',
                            style: textTheme.textBlack.copyWith(
                              // color: LdColors.orangeWarning,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Cambien su nombre de usuario',
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
                      'Nombre de usuario  *',
                      hintText: 'Ingresa tu nuevo Nickname ',
                      controller: nickNameCtrl,
                      onChange: (String value) =>
                          viewModel.changeNickName(value),
                      changeFillWith: !viewModel.status.isNickNameFieldEmpty,
                      textInputAction: TextInputAction.next,
                      maxLength: 40,
                      counterText: '',
                      validator: (String? str) =>
                          viewModel.validatorNickName(str),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryButtonCustom(
                      'Actualizar',
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (keyForm.currentState!.validate()) {
                          viewModel.changeDataUser(
                            context,
                            nickNameCtrl.text,
                            dataUserProvider,
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
    );
  }
}
