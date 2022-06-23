part of 'detail_support_view.dart';

class DetailSupportMobile extends StatelessWidget {
  const DetailSupportMobile(
      // this.nickNameCtrl,
      {
        Key? key,
        required this.keyForm,

        // required this.scrollCtrl,
      }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  // final TextEditingController nickNameCtrl;

  @override
  Widget build(BuildContext context) {
    final DetailSupportViewModel viewModel =
    context.watch<DetailSupportViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 120;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      body: Column(
        children: <Widget>[
          AppBarBigger(
            title: 'Detalles del caso',
            hAppbar: hAppbar,
            textTheme: textTheme,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
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
                      //TODO implement detail suport case
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
                        // controller: nickNameCtrl,
                        // onChange: (String value) =>
                        //     viewModel.changeNickName(value),
                        // changeFillWith: !viewModel.status.isNickNameFieldEmpty,
                        textInputAction: TextInputAction.next,
                        maxLength: 40,
                        counterText: '',
                        // validator: (String? str) =>
                        //     viewModel.validatorNickName(str),
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                        // ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PrimaryButtonCustom(
                        'Actualizar',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (keyForm.currentState!.validate()) {
                            // viewModel.changeDataUser(
                            //   context,
                            //   nickNameCtrl.text,
                            //   dataUserProvider,
                            // );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

