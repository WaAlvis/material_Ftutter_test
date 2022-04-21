part of '../detail_oper_offer_view.dart';

class CardDetailinfo extends StatelessWidget {
  const CardDetailinfo({Key? key, required this.textTheme, required this.isBuy})
      : super(key: key);
  final TextTheme textTheme;
  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Text(
                isBuy ? 'Cantidad a vender' : 'Cantidad a vender',
                style: textTheme.textGray.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  '1.000.000',
                  style: textTheme.titleBigBlack
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SvgPicture.asset(
                LdAssets.dlycop,
                height: 24,
                width: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: <Widget>[
              FittedBox(
                alignment: Alignment.topLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  '1 DLYCOP ≈ 1 COP ',
                  style: textTheme.textBlack.copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: <Widget>[
              FittedBox(
                alignment: Alignment.topLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  '= 1.000.000 COP',
                  style: textTheme.titleBigBlack.copyWith(
                      fontSize: 24,
                      color: LdColors.orangePrimary,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
