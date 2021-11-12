part of '../home_view.dart';

class CardBuyAndSell extends StatelessWidget {
  const CardBuyAndSell({
    Key? key,
    required this.items,
    required this.textTheme,
    required this.index,
  }) : super(key: key);

  final List<Map<String, String>> items;
  final TextTheme textTheme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InfoValueCard(
                        title: 'Cantidad',
                        valueMoney: items[index]['value1']!,
                        textTheme: textTheme,
                      ),
                      const SizedBox(height: 5),
                      InfoValueCard(
                        title: 'Costo',
                        valueMoney: items[index]['value2']!,
                        textTheme: textTheme,
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.maxFinite,
                        child: Flexible(
                          child: Text(
                            'Transferencia bancaria nacional. ${items[index]['banco']}.',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 3,
                            style: textTheme.textSmallBlack.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Flexible(
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TitleBarCard extends StatelessWidget {
  final String name;
  final String stars;
  final TextTheme textTheme;

  const TitleBarCard({
    Key? key,
    required this.name,
    required this.stars,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.account_circle,
          color: LdColors.black,
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: textTheme.textSmallBlack,
        ),
        const Spacer(),
        const Icon(Icons.star),
        const SizedBox(width: 3),
        Text(stars),
      ],
    );
  }
}
