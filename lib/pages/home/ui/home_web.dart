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

    return Scaffold(
      appBar: const LdAppbar(title: 'Test'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
              color: LdColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.3,
                      vertical: 30,
                    ),
                    color: LdColors.black,
                    child: Column(
                      children: <Widget>[
                        RichText(
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
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            'Únase al intercambio global de DLY COP de más rápido crecimiento, con las tarifas más bajas.',
                            style: textTheme.textBigWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: LdColors.black,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1, vertical: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      style:
                                          textTheme.titleMediumWhite.copyWith(
                                        fontSize: 45,
                                      ),
                                      text: 'Compre y venda ',
                                    ),
                                    TextSpan(
                                      style:
                                          textTheme.titleMediumYellow.copyWith(
                                        fontSize: 45,
                                      ),
                                      text: 'DLY COP ',
                                    ),
                                    TextSpan(
                                      style:
                                          textTheme.titleMediumWhite.copyWith(
                                        fontSize: 45,
                                      ),
                                      text: 'desde cualquier lugar',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Descubra cómo funcionan DLY COP y comercie con la moneda.',
                                style: textTheme.textWhite,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 35),
                              Container(
                                width: 150,
                                height: 40,
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
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox.shrink())
                      ],
                    ),
                  ),
                  const LdFooter()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
