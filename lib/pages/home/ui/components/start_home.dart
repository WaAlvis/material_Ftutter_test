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
                color: LdColors.grayLight,
              ),
            ),
            Text(
              title,
              style: textTheme.subtitleBlack.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              description,
              style: textTheme.textBigBlack,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      color: LdColors.white,
      child: Column(
        children: <Widget>[
          Text(
            'Empezar',
            style: textTheme.textBigBlack,
            textAlign: TextAlign.left,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: textTheme.titleBigBlack,
                  text: 'Compra ',
                ),
                TextSpan(
                  style: textTheme.titleBigYellow,
                  text: 'DLY COP ',
                ),
                TextSpan(
                  style: textTheme.titleBigBlack,
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
