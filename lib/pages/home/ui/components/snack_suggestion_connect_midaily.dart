import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/appbar_circles.dart';

class SnackSuggestionConnectMiDaily extends StatelessWidget {
  const SnackSuggestionConnectMiDaily( this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return       Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          const CircleDecoration(quarter: 1, color: LdColors.orangePrimary),
          const CircleDecoration(quarter: 2, color: LdColors.orangePrimary),
          const CircleDecoration(quarter: 3, color: LdColors.orangePrimary),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.account_balance_wallet,
                  color: LdColors.orangePrimary,
                  size: 20,
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Text(
                    message,
                    style: textTheme.textSmallBlack.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // backgroundColor: LdColors.white,
      // behavior: SnackBarBehavior.floating,
      // duration: const Duration(seconds: 3),
    );
  }
}
