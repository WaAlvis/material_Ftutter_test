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
          children: <Widget>[
            Container(
              width: 329,
              height: 212,
              decoration: const BoxDecoration(
                color: LdColors.grayLight,
              ),
            ),
            Text(
              title,
              style: textTheme.subtitleWhite.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: textTheme.textBigWhite,
              textAlign: TextAlign.left,
            ),
            Text(
              'Leer más',
              style: textTheme.textBigYellow,
              textAlign: TextAlign.left,
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      color: LdColors.black,
      child: Column(
        children: <Widget>[
          Text(
            'Obtén información',
            style: textTheme.textBigWhite,
            textAlign: TextAlign.left,
          ),
          Text(
            'Profundiza tu investigación',
            style: textTheme.titleBigWhite,
            textAlign: TextAlign.center,
          ),
          Text(
            'Con cualquier inversión, es importante comprender lo que estás comprando. Explora estos recursos y regresa para conocer más formas de ampliar tus conocimientos sobre las criptomonedas.',
            style: textTheme.textBigWhite,
            textAlign: TextAlign.center,
          ),
          Row(
            children: <Widget>[
              _columnSection('Inscribirse', ''),
              _columnSection('Fondo', ''),
              _columnSection('Comprar', ''),
            ],
          )
        ],
      ),
    );
  }
}
