part of 'buy_sell_view.dart';

class _BuySellWeb extends StatelessWidget {

  const _BuySellWeb({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
    required this.isBuy
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;
  final bool isBuy;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final BuySellViewModel viewModel = context.watch<BuySellViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const LdAppbar('Test'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
              color: LdColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.13, vertical: 30,
                    ),
                    color: LdColors.black,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Compre y venda ',
                                  style: textTheme.titleBigWhite,
                                ),
                                TextSpan(
                                  style: textTheme.titleBigYellow,
                                  text: 'DLY COP ',
                                ),
                                TextSpan(
                                  style: textTheme.titleBigWhite,
                                  text: 'desde cualquier lugar.',
                                )
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Expanded(child: SizedBox.shrink())
                      ],
                    ),
                  ),
                  _FilterBuySell(isBuy: isBuy),
                  _TableBuySell(isBuy: isBuy),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 350,
                        height: 40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10, bottom: 50),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: LdColors.grayButton,
                        ),
                        child: Text(
                          isBuy ? 'Cargar más compras' : 'Cargar más ventas',
                          style: textTheme.textBlack.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
