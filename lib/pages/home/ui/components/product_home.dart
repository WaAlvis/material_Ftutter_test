part of '../home_view.dart';

class _ProductHome extends StatelessWidget {
  const _ProductHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      color: const Color(0xfffafafa),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Column(
              children: <Widget>[
                const Text(
                  'Producto',
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
                          color: Color(0xff040505),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 65.0,
                        ),
                        text: 'Tus ',
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
                          color:  Color(0xff040505),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 65.0,
                        ),
                        text: 'al alcance de tu mano',
                      )
                    ],
                  ),
                ),
                const Text(
                  'Verifica tu cuenta, obtén fondos y realiza un seguimiento de tus activos en todas sus pantallas. Ya sea tu primera o milésima inversión, tenemos las herramientas ideales para ti.',
                  style: TextStyle(
                    color: Color(0xff3e4462),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'GTWalsheimPro',
                    fontStyle:  FontStyle.normal,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                Container(
                  width: 610,
                  height: 145,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(22),
                    ),
                    color: Color(0xff040505),
                  ),
                  child: Column(
                    children: const <Widget>[
                      Text(
                        'Nuevos inversores',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Hacemos que sea fácil entender y comprar tus primeras DLY COP.',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                // Rectangle 10
                Container(
                  width: 610,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xffe6e922),
                  ),
                  child: const Text(
                    'Empieza a comprar y vender DLY COP',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 787,
              height: 570,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(28),
                ),
                color: Color(0xffc4c4c4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
