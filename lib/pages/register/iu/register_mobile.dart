part of 'register_view.dart';

class _RegisterMobile extends StatelessWidget {
  const _RegisterMobile({
    Key? key,
    required this.keyForm,
    required this.emailCtrl,
    required this.nickNameCtrl,
    required this.firstNameCtrl,
    required this.firstLastNameCtrl,
    required this.secondNameCtrl,
    required this.secondLastNameCtrl,
    required this.phoneCtrl,
    required this.dateBirthCtrl,
    required this.passwordCtrl,
    required this.confirmPassCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController emailCtrl;
  final TextEditingController nickNameCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController firstLastNameCtrl;
  final TextEditingController secondNameCtrl;
  final TextEditingController secondLastNameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController dateBirthCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: LdColors.white,
      extendBodyBehindAppBar: true,
      appBar: const LdAppbar(
        title: 'Crear cuenta',
        // withBackIcon: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (viewModel.status.indexStep == 2)
            const SizedBox.shrink()
          else
            Container(
              width: size.width,
              color: LdColors.blackBackground,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  // Esto es el circulo, ideal volverlo widget
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
                  if (viewModel.status.indexStep == 1)
                    SectionTitleAppbar(context,
                        step: 1,
                        title: 'Crear mi cuenta',
                        description:
                            'Para continuar ingresa tu correo electronico.')
                  else if (viewModel.status.indexStep == 3)
                    SectionTitleAppbar(context,
                        step: 3,
                        title: 'Validacion del correo',
                        description:
                            'Ingresa el codigo enviado al Email de registro.')
                  else if (viewModel.status.indexStep == 4)
                    SectionTitleAppbar(context,
                        step: 4,
                        title: 'Informacion de la cuenta',
                        description:
                            'Escribe la informacion de registro de tu cuenta.'),
                ],
              ),
            ),
          if (viewModel.status.indexStep == 1)
            FirstStepRegister(
              keyFirstForm: keyForm,
              emailCtrl: emailCtrl,
              viewModel: viewModel,
            )
          else if (viewModel.status.indexStep == 2)
            SecondStepRegister(
              viewModel: viewModel,
            )
          else if (viewModel.status.indexStep == 3)
            ThirdStepRegister(
              viewModel: viewModel,
            )
          else if (viewModel.status.indexStep == 4)
            FourthStepRegister(
              viewModel: viewModel,
              keyForm: keyForm,
              nickNameCtrl: nickNameCtrl,
              firstNameCtrl: firstNameCtrl,
              firstLastNameCtrl: firstLastNameCtrl,
              secondNameCtrl: secondNameCtrl,
              secondLastNameCtrl: secondLastNameCtrl,
              phoneCtrl: phoneCtrl,
              dateBirthCtrl: dateBirthCtrl,
              passwordCtrl: passwordCtrl,
              confirmPassCtrl: confirmPassCtrl,
            ),
        ],
      ),
    );
  }
}

Widget SectionTitleAppbar(BuildContext context,
    {required int step, required String title, required String description}) {
  final TextTheme textTheme = Theme.of(context).textTheme;
  final Size size = MediaQuery.of(context).size;

  return Padding(
    padding: EdgeInsets.only(left: 16, top: size.height * 0.15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
          width: (size.width - 32) * step / 4 - 50,
          height: 5,
          decoration: const BoxDecoration(
            color: LdColors.orangePrimary,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  ); //   InkWell(
}
