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
              width: 182,
              height: 182,
              decoration: const BoxDecoration(
                color: LdColors.grayLight,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: textTheme.subtitleBlack.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(
                description,
                style: textTheme.textBlack,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 50),
      color: LdColors.white,
      child: Column(
        children: <Widget>[
          Text(
            'Empezar',
            style: textTheme.textBigBlack.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.2,
              right: size.width * 0.2,
              top: 5, bottom: 50,
            ),
            child: RichText(
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
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
