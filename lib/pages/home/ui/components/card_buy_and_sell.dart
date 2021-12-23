part of '../home_view.dart';

class CardBuyAndSell extends StatelessWidget {
  const CardBuyAndSell({
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
    return GestureDetector(
      onTap: () => viewModel.goLogin(context), //asi pase bien la navegacion?
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
            children: <Widget>[
              TitleBarCard(
                // name: item.user.nickName,
                name: item.user.nickName,
                stars: '+${item.user.rateSeller}',
                // time: item.advertisement.expiredDate,
                time:'7d',
                textTheme: textTheme,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
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
                        valueMoney: NumberFormat.decimalPattern()
                            .format(double.parse(item.advertisement.valueToSell)),
                        textTheme: textTheme,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: 'Valor ',
                          style: textTheme.textSmallBlack
                              .copyWith(color: LdColors.grayText, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                              text: item.advertisement.margin,
                              style: textTheme.textGray,
                            ),
                            const TextSpan(text: ' COP/DLY'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Flexible(
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Divider(
                  color: LdColors.gray,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  'Transferencia bancaria nacional.',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 3,
                  style: textTheme.textSmallBlack.copyWith(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
