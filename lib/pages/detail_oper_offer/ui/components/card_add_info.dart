part of '../detail_oper_offer_view.dart';

class CardAddInfo extends StatelessWidget {
  const CardAddInfo({Key? key, required this.textTheme, required this.addInfo})
      : super(key: key);
  final TextTheme textTheme;
  final String addInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      addInfo,
      style: textTheme.textBlack.copyWith(
        fontSize: 16,
      ),
      textAlign: TextAlign.left,
    );
  }
}
