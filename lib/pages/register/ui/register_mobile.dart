part of 'register_view.dart';

class _RegisterMobile extends StatelessWidget {
  const _RegisterMobile({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Bienvenido!',
            style: TextStyle(fontSize: 34),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Para continuar, ingresa tu correo electrónico.'),
          SizedBox(
            height: 40,
          ),
          Text('Correo electronico'),
          SizedBox(
            height: 5,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              hintText: 'ejemplo@correo.com',
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Spacer(),
          ElevatedButton(
              onPressed: () => locator<LdRouter>().goValidateEmail(context),
              // onPressed: () { print('Navegando a validacion de email');},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 42),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Enviar link de verificacion'))
        ],
      ),
    );
  }
}
