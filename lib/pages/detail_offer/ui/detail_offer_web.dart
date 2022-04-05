part of 'detail_offer_view.dart';

class _DetailOfferWeb extends StatelessWidget {
  const _DetailOfferWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DetailOfferViewModel viewModel =
        context.watch<DetailOfferViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const LdAppbar(title: 'Test'),
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
