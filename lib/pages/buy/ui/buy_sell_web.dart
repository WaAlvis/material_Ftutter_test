part of 'buy_sell_view.dart';

class _BuySellWeb extends StatelessWidget {

  const _BuySellWeb({
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
                  const _FilterBuySell(),
                  const _TableBuySell(isBuy: true),
                  const LdFooter()
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
