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
                color: Color(0xffc4c4c4),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontFamily: 'GTWalsheimPro',
                fontStyle: FontStyle.normal,
                fontSize: 36.0,
              ),
              textAlign: TextAlign.left,
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.w400,
                fontFamily: 'GTWalsheimPro',
                fontStyle:  FontStyle.normal,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.left,
            ),
            const Text(
              'Leer más',
              style: TextStyle(
                color: Color(0xffe6e922),
                fontWeight: FontWeight.w400,
                fontFamily: 'GTWalsheimPro',
                fontStyle: FontStyle.normal,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      color: const Color(0xff101011),
      child: Column(
        children: <Widget>[
          const Text(
            'Obtén información',
            style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.w400,
              fontFamily: 'GTWalsheimPro',
              fontStyle:  FontStyle.normal,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.left,
          ),
          const Text(
            'Profundiza tu investigación',
            style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.w700,
              fontFamily: 'GTWalsheimPro',
              fontStyle:  FontStyle.normal,
              fontSize: 65.0,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Con cualquier inversión, es importante comprender lo que estás comprando. Explora estos recursos y regresa para conocer más formas de ampliar tus conocimientos sobre las criptomonedas.',
            style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.w400,
              fontFamily: 'GTWalsheimPro',
              fontStyle:  FontStyle.normal,
              fontSize: 24.0,
            ),
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
