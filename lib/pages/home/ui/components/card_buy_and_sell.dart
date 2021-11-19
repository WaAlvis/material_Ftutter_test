part of '../home_view.dart';

class CardBuyAndSell extends StatelessWidget {
  const CardBuyAndSell({
    Key? key,
    required this.items,
    required this.textTheme,
    required this.index,
    required this.viewModel,
  }) : super(key: key);

  final List<Map<String, String>> items;
  final TextTheme textTheme;
  final int index;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => viewModel.dataHome(context), //asi pase bien la navegacion?
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: Column(
            children: <Widget>[
              TitleBarCard(
                name: items[index]['nickname']!,
                stars: '${items[index]['stars']!} +',
                time: items[index]['time']!,
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
                        valueMoney: items[index]['value1']!,
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
                              text: items[index]['value2'],
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
                child: Flexible(
                  child: Text(
                    'Transferencia bancaria nacional. ${items[index]['banco']}.',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 3,
                    style: textTheme.textSmallBlack.copyWith(
                      fontSize: 12,
                    ),
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
