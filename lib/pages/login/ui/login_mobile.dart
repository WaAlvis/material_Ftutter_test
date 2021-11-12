part of 'login_view.dart';

class _LoginMobile extends StatelessWidget {
  const _LoginMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: LdColors.grayBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '¡Bienvenido!',
            style: textTheme.textBigBlack,
          ),
          const SizedBox(height: 20),
          Text(
            'Inicia sesión en LocalDaily',
            style: textTheme.textBigBlack,
          ),
          const SizedBox(height: 40),
          Text(
            'Nombre de usuario *',
            style: textTheme.textBigBlack,
          ),
          const SizedBox(height: 5),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              hintText: 'Ingresa tu usuario',
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Contraseña *',
            style: textTheme.textBigBlack,
          ),
          const SizedBox(height: 5),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              hintText: '8+ digitos',
              suffixIcon: Icon(
                Icons.visibility_off,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: ()=> viewModel.goRegister(context),
            child: Text(
              'Olvidé mi contraseña',
              style: textTheme.textBlack.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            '¿No tienes cuenta en LocalDaily?',
            style: textTheme.textBlack,
          ),
          const SizedBox(height: 20),
          Text(
            'Crear cuenta',
            style: textTheme.textBlack.copyWith(
                decoration: TextDecoration.underline,
            ),
          ),
          const Spacer(),
          const _PrimaryButton()
        ],
      ),
    );
  }
}
