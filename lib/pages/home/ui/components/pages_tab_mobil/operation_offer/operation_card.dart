part of '../../../home_view.dart';

class OperationCard extends StatelessWidget {
  const OperationCard({
    Key? key,
    required this.item,
    required this.textTheme,
    required this.viewModel,
    required this.onTap,
  }) : super(key: key);

  final Data item;
  final TextTheme textTheme;
  final HomeViewModel viewModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    String totalValueCalculate(String margin, String amount) {
      final double totalCost = double.parse(margin) * int.parse(amount);
      return totalCost.toString();
    }

    return GestureDetector(
      onTap: onTap, //asi pase bien la navegacion?
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
              TitleBarCard2(
                code: '',
                // TODO: hacer match del id
                state: 0,
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
                      InfoValueCard2(
                        title: 'Cantidad',
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
                  ).format(double.parse(
                    totalValueCalculate(item.advertisement.margin,
                        item.advertisement.valueToSell),
                  ))} COP',
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

class InfoValueCard2 extends StatelessWidget {
  const InfoValueCard2({
    Key? key,
    required this.textTheme,
    required this.title,
    required this.valueMoney,
  }) : super(key: key);

  final TextTheme textTheme;
  final String title;
  final String valueMoney;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: textTheme.textSmallWhite.copyWith(fontSize: 13),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              valueMoney,
              style:
                  textTheme.textBigBlack.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25,
              child: SvgPicture.asset(
                LdAssets.dlycopIconBlack,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TitleBarCard2 extends StatelessWidget {
  final String code;
  final int state;
  final TextTheme textTheme;

  const TitleBarCard2({
    Key? key,
    required this.code,
    required this.state,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double sizeFont = 12.0;
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
          child: Text(
            state == 0
                ? 'Abierto'
                : state == 1
                    ? 'En proceso'
                    : 'Cerrado',
            style: textTheme.textSmallWhite.copyWith(color: LdColors.white),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
