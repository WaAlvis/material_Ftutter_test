part of '../offert_buy_view.dart';

class OrangeTableBuy extends StatelessWidget {
  const OrangeTableBuy({
    Key? key,
    required this.textTheme,
    // this.dlyCopValue = '0',
  }) : super(key: key);

  final TextTheme textTheme;

  // final String dlyCopValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: LdColors.orangePrimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '0',
                style: textTheme.subtitleWhite,
              ),
              SvgPicture.asset(LdAssets.dlycop_icon),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text('≈ 1.000.000 COP')
        ],
      ),
    );
  }

// Row rowOrangeTable({required String firstText, required String secondText}) {
//   final TextStyle style = textTheme.textWhite.copyWith(
//       color: LdColors.grayBg.withOpacity(0.6), fontWeight: FontWeight.w100);
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Text(
//         firstText,
//         style: style,
//       ),
//       Text(
//         secondText,
//         style: style,
//       ),
//     ],
//   );
// }
}
