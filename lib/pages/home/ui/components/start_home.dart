part of '../home_view.dart';

class _StartHome extends StatelessWidget {
  const _StartHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;


    Widget _columnSection (String title, String description) {

      return Flexible(
        child: Column(
          children: <Widget>[
            Container(
              width: 212,
              height: 212,
              decoration: const BoxDecoration(
                color: Color(0xffc4c4c4),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontFamily: 'GTWalsheimPro',
                fontStyle:  FontStyle.normal,
                fontSize: 36.0,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              description,
              style: const TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                fontStyle:  FontStyle.normal,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      color: const Color(0xffffffff),
      child: Column(
        children: <Widget>[
          const Text(
            'Empezar',
            style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
              fontFamily: 'GTWalsheimPro',
              fontStyle:  FontStyle.normal,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.left,
          ),
          RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'GTWalsheimPro',
                    fontStyle:  FontStyle.normal,
                    fontSize: 65.0,
                  ),
                  text: 'Compra ',
                ),
                TextSpan(
                  style: TextStyle(
                    color: Color(0xffe6e922),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'GTWalsheimPro',
                    fontStyle:  FontStyle.normal,
                    fontSize: 65.0,
                  ),
                  text: 'DLY COP ',
                ),
                TextSpan(
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'GTWalsheimPro',
                    fontStyle:  FontStyle.normal,
                    fontSize: 65.0,
                  ),
                  text: 'en minutos',
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              _columnSection('Inscribirse', 'Crea una cuenta gratis mediante un proceso de verificación rápido. Es así de fácil.'),
              _columnSection('Fondo', 'Haz una prueba o anímate del todo. Conecta tu cuenta bancaria de manera segura, no retendremos nunca tu información bancaria.'),
              _columnSection('Comprar', 'Si estás listo para comprar, te facilitaremos la transacción. Con solo tocar un botón, tu yo del futuro te lo agradecerá.'),
            ],
          )
        ],
      ),
    );
  }
}
