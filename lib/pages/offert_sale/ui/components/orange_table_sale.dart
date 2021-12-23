part of '../offert_sale_view.dart';

class OrangeTableSale extends StatelessWidget {
  const OrangeTableSale({
    Key? key,
    required this.textTheme,
    this.onlyIntNum = false,
    this.controller,
    // this.dlyCopValue = '0',
  }) : super(key: key);

  final TextTheme textTheme;
  final bool onlyIntNum;
  final TextEditingController? controller;

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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: controller,
                  inputFormatters: onlyIntNum
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  keyboardType: TextInputType.number,
                  style: textTheme.subtitleWhite,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: textTheme.subtitleWhite,
                  ),
                ),
              ),
              SvgPicture.asset(LdAssets.dlycop_icon),
            ],
          ),
          const Divider(
            thickness: 1,
            color: LdColors.whiteDark,
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Valor',
            secondText: '1 DLY ≈ 1 COP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Fee(1%)',
            secondText: '0 DLYCOP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Total',
            secondText: '0 DLYCOP',
          ),
        ],
      ),
    );
  }

  Row rowOrangeTable({required String firstText, required String secondText}) {
    final TextStyle style = textTheme.textWhite.copyWith(
        color: LdColors.grayBg.withOpacity(0.6), fontWeight: FontWeight.w100);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          firstText,
          style: style,
        ),
        Text(
          secondText,
          style: style,
        ),
      ],
    );
  }
}
