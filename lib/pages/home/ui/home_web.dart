part of 'home_view.dart';

class _HomeWeb extends StatelessWidget {

  const _HomeWeb({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {

    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
      color: LdColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: LdColors.black,
            child: Column(
              children: <Widget>[
                PositionedDirectional(
                  top: 0,
                  start: 0,
                  child: RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Compra y vende tus ',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'GTWalsheimPro',
                            fontStyle: FontStyle.normal,
                            fontSize: 65.0,
                          ),
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xffe6e922),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'GTWalsheimPro',
                            fontStyle: FontStyle.normal,
                            fontSize: 65.0,
                          ),
                          text: 'DLY COP ',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'GTWalsheimPro',
                            fontStyle: FontStyle.normal,
                            fontSize: 65.0,
                          ),
                          text: ' en minutos',
                        )
                      ],
                    ),
                  ),
                ),
                const PositionedDirectional(
                  top: 178,
                  start: 30,
                  child: Text(
                    'Únase al intercambio global de DLY COP de más rápido crecimiento, con las tarifas más bajas.',
                    style: TextStyle(
                      color:  Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'GTWalsheimPro',
                      fontStyle:  FontStyle.normal,
                      fontSize: 24.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          /*Flexible(
            child: Container(
              width: 1450,
              height: 250,
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
                  TextButton(
                    onPressed: ()=> viewModel.goHome(context),
                    child: const Text(
                      'Presiona aqui',
                    ),
                  ),
                  Row(
                    children: const <Widget>[
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
                        'Vendedor',
                        style: TextStyle(
                          color:  Color(0xff888696),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),*/
          const _TableHome(),
          const _TableHome(),
          const _ProductHome(),
          const _StartHome(),
          const _SecurityHome(),
          const _InformationHome(),
          Container(
            color: const Color(0xff101011),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'GTWalsheimPro',
                                fontStyle:  FontStyle.normal,
                                fontSize: 56.0,
                              ),
                              text: 'Compre y venda ',
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xffe6e922),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'GTWalsheimPro',
                                fontStyle:  FontStyle.normal,
                                fontSize: 56.0,
                              ),
                              text: 'DLY COP ',
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'GTWalsheimPro',
                                fontStyle:  FontStyle.normal,
                                fontSize: 56.0,
                              ),
                              text: ' desde cualquier lugar',
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Descubra cómo funcionan DLY COP y comercie con la moneda.',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      // Rectangle 10
                      Container(
                        width: 160,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Color(0xffe6e922),
                        ),
                        child: const Text(
                          'Empezar',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'GTWalsheimPro',
                            fontStyle:  FontStyle.normal,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                const Expanded(child: SizedBox.shrink())
              ],
            ),
          )
        ],
      ),
    );
  }
}
