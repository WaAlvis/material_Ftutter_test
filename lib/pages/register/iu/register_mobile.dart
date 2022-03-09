part of 'register_view.dart';

class _RegisterMobile extends StatelessWidget {
  const _RegisterMobile({
    Key? key,
    required this.keyForm,
    required this.emailCtrl,
    required this.namesCtrl,
    required this.surnamesCtrl,
    required this.nickNameCtrl,
    required this.phraseCtrl,
    required this.phoneCtrl,
    required this.dateBirthCtrl,
    required this.passwordCtrl,
    required this.confirmPassCtrl,
    required this.codePinCtrl,
    required this.addressWalletCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController emailCtrl;
  final TextEditingController namesCtrl;
  final TextEditingController surnamesCtrl;
  final TextEditingController phraseCtrl;
  final TextEditingController nickNameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController dateBirthCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;
  final TextEditingController codePinCtrl;
  final TextEditingController addressWalletCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
    final Size size = MediaQuery.of(context).size;
    const double hAppbar = 190;
    final double hBody = size.height - hAppbar;
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: LdColors.white,
        extendBodyBehindAppBar: true,
        appBar: const LdAppbar(
          title: 'Crear cuenta',
          // withBackIcon: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (viewModel.status.registerStep == RegisterStep.msjEmailStep_2)
              const SizedBox.shrink()
            else
              const AppbarCircles(hAppbar: hAppbar),
            if (viewModel.status.registerStep == RegisterStep.emailStep_1)
              Step1EmailRegister(
                keyForm: keyForm,
                emailCtrl: emailCtrl,
                viewModel: viewModel,
              )
            else if (viewModel.status.registerStep ==
                RegisterStep.msjEmailStep_2)
              Step2MsjEmail(
                viewModel: viewModel,
              )
            else if (viewModel.status.registerStep ==
                RegisterStep.validatePinStep_3)
              Step3ValidatePin(
                viewModel: viewModel,
                heightBody: hBody,
                codePinCtrl: codePinCtrl,
              )
            else if (viewModel.status.registerStep ==
                RegisterStep.accountDataStep_4)
              Step4AccountData(
                viewModel: viewModel,
                keyForm: keyForm,
                nickNameCtrl: nickNameCtrl,
                passwordCtrl: passwordCtrl,
                confirmPassCtrl: confirmPassCtrl,
              )
            else if (viewModel.status.registerStep ==
                RegisterStep.personalDataStep_5)
              Step5PersonalData(
                viewModel: viewModel,
                keyForm: keyForm,
                namesCtrl: namesCtrl,
                surnamesCtrl: surnamesCtrl,
                dateBirthCtrl: dateBirthCtrl,
                phoneCtrl: phoneCtrl,
              )
            else if (viewModel.status.registerStep ==
                RegisterStep.dataWalletStep_6)
              Step6RestoreWallet(
                viewModel: viewModel,
                keyForm: keyForm,
                phraseCtrl: phraseCtrl,
                dataUserProvider: dataUserProvider,
              )

            //  if (viewModel.status.registerStep == RegisterStep.dataAccountStep_4)
            //               FourthStepRegister(
            //                 viewModel: viewModel,
            //                 keyForm: keyForm,
            //                 nickNameCtrl: nickNameCtrl,
            //                 firstNameCtrl: firstNameCtrl,
            //                 firstLastNameCtrl: firstLastNameCtrl,
            //                 secondNameCtrl: secondNameCtrl,
            //                 secondLastNameCtrl: secondLastNameCtrl,
            //                 phoneCtrl: phoneCtrl,
            //                 dateBirthCtrl: dateBirthCtrl,
            //                 passwordCtrl: passwordCtrl,
            //                 confirmPassCtrl: confirmPassCtrl,
            //                 addressWalletCtrl: addressWalletCtrl,
            //                 dataUserProvider: dataUserProvider,
            //               ),
          ],
        ),
      ),
    );
  }
}

Widget sectionTitleAppbar(
  BuildContext context, {
  required int step,
  required String title,
  required String description,
  required double heightAppbar,
}) {
  final TextTheme textTheme = Theme.of(context).textTheme;
  final Size size = MediaQuery.of(context).size;

  return SizedBox(
    height: heightAppbar,
    child: Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: textTheme.textBigWhite,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: textTheme.textSmallWhite.copyWith(
              color: LdColors.grayBg,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: (size.width - 32) * step / RegisterStep.values.length - 50,
            height: 5,
            decoration: const BoxDecoration(
              color: LdColors.orangePrimary,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  ); //   InkWell(
}
