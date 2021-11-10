part of 'validate_email_view.dart';

class _ValidateEmailMobile extends StatelessWidget {
  const _ValidateEmailMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: LdColors.grayBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/correo.png'),
          Text(
            'Verifica tu correo',
            style: TextStyle(fontSize: 34),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Confirma tu dirección de correo electrónico haciendo clic en el enlace que hemos enviado a:',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text('juan.vega@gmail.com',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(
            height: 5,
          ),

          SizedBox(
            height: 40,
          ),
          Spacer(),
          new Text(
            "Reenviar link de correo",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () => locator<LdRouter>().goPersonalInfoRegister(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 42),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Abrir correo'))
        ],
      ),
    );
  }
}
