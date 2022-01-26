part of 'detail_offer_buy_view.dart';

class _DetailOffertBuyWeb extends StatelessWidget {

  const _DetailOffertBuyWeb({
    Key? key,
    required this.keyForm,
    required this.valueDLYCOP,
    required this.isBuy,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController valueDLYCOP;
  final bool isBuy;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final DetailOfferBuyViewModel viewModel = context.watch<DetailOfferBuyViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const LdAppbar(title:'Test'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
              color: LdColors.whiteGray,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height - 100,
                    child: const Center(),
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
