part of '../register_email_view.dart';

class _CardRegister extends StatelessWidget {
  const _CardRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
    final Size size = MediaQuery.of(context).size;

    Widget _columnData(String title){

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            title,
            style: textTheme.textBlack,
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 42,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: LdColors.grayBorder,
              ),
              color: LdColors.white,
            ),
            child: Text(
              title,
              style: textTheme.textGray.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    }

    Widget _twoRows(String oneTitle,String twoTitle) {

      return Row(
        children: <Widget>[
          Expanded(
            child: _columnData(oneTitle),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _columnData(twoTitle),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: size.width * 0.35,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(17)),
              border: Border.all(color: LdColors.whiteDark),
              color: LdColors.white,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    'Registrate en LocalDaily',
                    style: textTheme.subtitleBlack.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                _twoRows('Nombre', 'Apellido'),
                _columnData('Fecha de nacimiento'),
                _columnData('Correo electrónico'),
                _twoRows('Contraseña*', 'Confirmar contraseña*'),
                const SizedBox(height: 25),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Crear una cuenta significa que estás de acuerdo con nuestros ',
                        style: textTheme.textSmallBlack,
                      ),
                      TextSpan(
                        text: 'Términos de servicio, Politica de privacidad.',
                        style: textTheme.textBlue.copyWith(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    color: LdColors.black,
                  ),
                  child: Text(
                    'Crear una cuenta',
                    style: textTheme.textWhite.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Este sitio está protegido por  reCAPTCHA y se aplica la ',
                        style: textTheme.textSmallBlack,
                      ),
                      TextSpan(
                        text: 'Politica de privacidad  y los Términos  de servicio ',
                        style: textTheme.textBlue.copyWith(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: 'de Google.',
                        style: textTheme.textSmallBlack,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
