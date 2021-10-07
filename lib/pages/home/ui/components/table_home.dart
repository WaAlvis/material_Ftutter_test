part of '../home_view.dart';

class _TableHome extends StatelessWidget {
  const _TableHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(17),
        ),
        border: Border.all(
          color: const Color(0xfff3f3f3),
        ),
        color: const Color(0xffffffff),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Comprar DLYs online en Colombia',
            style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
              fontFamily: 'GTWalsheimPro',
              fontStyle:  FontStyle.normal,
              fontSize: 36.0,
            ),
            textAlign: TextAlign.left,
          ),
          Table(
            children: const <TableRow>[
              TableRow(
                children: <Widget>[
                  Text(
                    'Vendedor',
                    style: TextStyle(
                      color: Color(0xff888696),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Puntuación',
                    style: TextStyle(
                      color: Color(0xff888696),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Forma de pago',
                    style: TextStyle(
                      color: Color(0xff888696),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Precio/DLY COP',
                    style: TextStyle(
                      color: Color(0xff888696),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Límites',
                    style: TextStyle(
                      color: Color(0xff888696),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Text(
                    'nashira60 ',
                    style: TextStyle(
                      color: Color(0xff0055ff),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '(100+; 99%) ',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Transferencias con un banco específico: bancolombia ',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '164,697,830.19 COP ',
                    style: TextStyle(
                      color: Color(0xff5aac6e),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '50,000 - 220,024 COP	 ',
                    style: TextStyle(
                      color: Color(0xff5aac6e),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),

                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
