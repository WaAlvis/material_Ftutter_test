part of 'validate_email_view.dart';

class _ValidateEmailMobile extends StatelessWidget {
  const _ValidateEmailMobile({
    Key? key,
    required this.keyForm,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: LdColors.grayBg,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('lib/assets/images/mail.svg'),
                Text(
                  'Verifica tu correo',
                  style: textTheme.textBigBlack
                      .copyWith(color: LdColors.orangePrimary),
                ),
                const SizedBox(
                  height: 36,
                ),
                Text(
                  'Confirma tu dirección de correo electrónico haciendo clic en el enlace que hemos enviado a:',
                  textAlign: TextAlign.center,
                  style: textTheme.textSmallBlack,
                ),
                const SizedBox(
                  height: 28,
                ),
                Text(
                  viewModel.status.emailRegister,
                  style:
                      textTheme.textBlack.copyWith(fontWeight: FontWeight.w500),
                ),  Text(
                  'viewModel.status.emailRegister',
                  style:
                      textTheme.textBlack.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 140,
                ),
                Text(
                  'Reenviar link de correo',
                  style: textTheme.textSmallBlack
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
          PrimaryButtonCustom(
            'Abrir correo',
            onPressed: () => viewModel.goRegisterPersonalData(context),
          ),
        ],
      ),
    );
  }
}
