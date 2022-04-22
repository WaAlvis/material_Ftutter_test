part of '../../../../../offer_sale/ui/offer_sale_view.dart';

class MyOfferCard extends StatelessWidget {
  const MyOfferCard({
    Key? key,
    required this.item,
    required this.textTheme,
    required this.viewModel,
  }) : super(key: key);

  final Data item;
  final TextTheme textTheme;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    String totalValueCalculate(String margin, String amount) {
      final double totalCost = double.parse(margin) * int.parse(amount);
      return totalCost.toString();
    }

    return GestureDetector(
      onTap: () => viewModel.goDetailOperOffer(
          context, item.advertisement.id), //asi pase bien la navegacion?
      child: Container(
        decoration: BoxDecoration(
          color: LdColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: LdColors.blackDark.withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: 0.2,
              offset: const Offset(0, 0.5),
            )
          ],
        ),
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TitleBarOffer(
                code: '# ${item.advertisement.reference}',
                state: int.parse(item.advertisement.idStatus),
                textTheme: textTheme,
              ),
              const Padding(
                padding: EdgeInsets.zero,
                child: Divider(
                  color: LdColors.gray,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InfoValueCard(
                        valueMoney: NumberFormat.simpleCurrency(
                          decimalDigits: 0,
                          name: '',
                          locale: 'IT',
                        ).format(
                          double.parse(item.advertisement.valueToSell),
                        ),
                        textTheme: textTheme,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '1 DLYCOP ≈ ${item.advertisement.margin} COP',
                        style: textTheme.textSmallBlack
                            .copyWith(color: LdColors.grayText, fontSize: 14),
                      ),
                    ],
                  ),
                  const Flexible(
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: LdColors.orangePrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  //Todo DA
                  '= ${NumberFormat.simpleCurrency(
                    decimalDigits: 0,
                    name: '',
                    locale: 'IT',
                  ).format(
                    double.parse(
                      totalValueCalculate(
                        item.advertisement.margin,
                        item.advertisement.valueToSell,
                      ),
                    ),
                  )} COP',
                  style: textTheme.textSmallBlack
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleBarOffer extends StatelessWidget {
  final String code;
  final int state;
  final TextTheme textTheme;

  const TitleBarOffer({
    Key? key,
    required this.code,
    required this.state,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double sizeFont = 14;
    return Row(
      children: <Widget>[
        const SizedBox(width: 8),
        Text(
          code,
          style: textTheme.textSmallBlack.copyWith(fontSize: sizeFont),
        ),
        const Spacer(),
        Container(
          width: 110,
          constraints: const BoxConstraints(maxWidth: 110),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: state == 0
                ? LdColors.blueState
                : state == 1
                    ? LdColors.greenState
                    : LdColors.grayState,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              state == 0
                  ? 'Abierto'
                  : state == 1
                      ? 'En proceso'
                      : state == 2
                          ? 'Cerrado'
                          : 'Pendiente',
              style: textTheme.textSmallWhite.copyWith(color: LdColors.white),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
