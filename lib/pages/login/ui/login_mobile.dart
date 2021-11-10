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
          Text('inicia sesión en LocalDaily'),
          SizedBox(
            height: 40,
          ),
          Text('Nombre de usuario *'),
          SizedBox(
            height: 5,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              hintText: 'Ingresa tu usuario',
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text('Contraseña *'),
          SizedBox(
            height: 5,
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              hintText: '8+ digitos',
              suffixIcon: Icon(
                Icons.visibility_off,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "myRoute");
            },
            child: new Text(
              "Olvidé mi contraseña",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text('¿No tienes cuenta en LocalDaily?'),
          SizedBox(
            height: 20,
          ),
          new Text(
            "Crear cuenta",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          Spacer(),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Ingresar'))
        ],
      ),
    );
  }
}
