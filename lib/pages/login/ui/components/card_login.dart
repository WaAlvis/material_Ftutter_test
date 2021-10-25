part of '../login_view.dart';

class _CardLogin extends StatelessWidget {
  const _CardLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: LdColors.grayBorder,
              ),
              color: LdColors.white,
            ),
            child: Text(
              title,
              style: textTheme.textGray,
              textAlign: TextAlign.start,
            ),
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
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                    'Iniciar sesión',
                    style: textTheme.subtitleBlack.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                _columnData('Correo electrónico'),
                _columnData('Contraseña'),
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
                    'Iniciar Sesión',
                    style: textTheme.textWhite.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  '¿Se te olvidó tu contraseña?',
                  style: textTheme.textBlue.copyWith(
                    decoration: TextDecoration.underline,
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
