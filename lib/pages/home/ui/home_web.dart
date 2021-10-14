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

    final TextTheme textTheme = Theme.of(context).textTheme;
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
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Compra y vende tus ',
                          style: textTheme.titleBigWhite,
                        ),
                        TextSpan(
                          style: textTheme.titleBigYellow,
                          text: 'DLY COP ',
                        ),
                        TextSpan(
                          style: textTheme.titleBigWhite,
                          text: 'en minutos',
                        )
                      ],
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 178,
                  start: 30,
                  child: Text(
                    'Únase al intercambio global de DLY COP de más rápido crecimiento, con las tarifas más bajas.',
                    style: textTheme.textBigWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
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
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              style: textTheme.titleMediumWhite,
                              text: 'Compre y venda ',
                            ),
                            TextSpan(
                              style: textTheme.titleMediumYellow,
                              text: 'DLY COP ',
                            ),
                            TextSpan(
                              style: textTheme.titleMediumWhite,
                              text: 'desde cualquier lugar',
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Descubra cómo funcionan DLY COP y comercie con la moneda.',
                        style: textTheme.textBigWhite,
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
                          color: LdColors.yellow,
                        ),
                        child: Text(
                          'Empezar',
                          style: textTheme.textBlack,
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
