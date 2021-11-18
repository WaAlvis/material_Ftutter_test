part of '../home_view.dart';

class _InformationHome extends StatelessWidget {
  const _InformationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    Widget _columnSection (String title, String description) {

      return Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 229,
              height: 182,
              decoration: const BoxDecoration(
                color: LdColors.grayLight,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: textTheme.subtitleWhite.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: textTheme.textWhite,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 25),
            Text(
              'Leer más',
              style: textTheme.textYellow.copyWith(
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 60),
      color: LdColors.black,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.17),
            child: Column(
              children: <Widget>[
                Text(
                  'Obtén información',
                  style: textTheme.textBigWhite,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 15),
                Text(
                  'Profundiza tu investigación',
                  style: textTheme.titleMediumWhite.copyWith(
                    fontSize: 48,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Con cualquier inversión, es importante comprender lo que estás comprando. Explora estos recursos y regresa para conocer más formas de ampliar tus conocimientos sobre las criptomonedas.',
                  style: textTheme.textWhite,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              _columnSection('Inscribirse', ''),
              const SizedBox(width: 35),
              _columnSection('Fondo', ''),
              const SizedBox(width: 35),
              _columnSection('Comprar', ''),
            ],
          )
        ],
      ),
    );
  }
}
