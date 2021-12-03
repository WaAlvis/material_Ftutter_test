
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';

import '../../../../app_theme.dart';

class OrangeTableSummary extends StatelessWidget {
  const OrangeTableSummary({
    Key? key,
    required this.textTheme,
    this.dlyCopValue = '0',
  }) : super(key: key);

  final TextTheme textTheme;
  final String dlyCopValue;

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
              Text(
                dlyCopValue,
                style: textTheme.subtitleWhite,
              ),
              SvgPicture.asset(LdAssets.dlycop_icon),
            ],
          ),
          const SizedBox(
            height: 5,
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
