part of '../../../home_view.dart';

class CardBuyAndSell extends StatelessWidget {
  const CardBuyAndSell({
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
              TitleBarCard(
                // name: item.user.nickName,
                name: item.user.nickName,
                stars: '+${item.user.rateSeller}',
                // time: item.advertisement.expiredDate,
                time: '7d',
                textTheme: textTheme,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
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
                        '${item.advertisement.margin} DLYCOP ≈ 1 COP',
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

class InfoValueCard extends StatelessWidget {
  const InfoValueCard({
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

class TitleBarCard extends StatelessWidget {
  final String name;
  final String stars;
  final TextTheme textTheme;
  final String time;

  const TitleBarCard({
    Key? key,
    required this.name,
    required this.time,
    required this.stars,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double sizeFont = 12.0;
    return Row(
      children: <Widget>[
        const Icon(
          Icons.account_circle,
          color: LdColors.black,
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: textTheme.textSmallBlack.copyWith(fontSize: sizeFont),
        ),
        const Spacer(),
        Text(
          time,
          style: textTheme.textSmallBlack
              .copyWith(fontWeight: FontWeight.w600, fontSize: sizeFont),
        ),
        const SizedBox(width: 16),
        const Icon(
          Icons.star,
          color: LdColors.orangePrimary,
          size: 20,
        ),
        const SizedBox(width: 3),
        Text(
          stars,
          style: textTheme.textSmallBlack.copyWith(fontSize: sizeFont),
        ),
      ],
    );
  }
}
