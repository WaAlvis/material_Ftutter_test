import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class WarningContainerMsj extends StatelessWidget {
  const WarningContainerMsj(
    this.textTheme, {
    required this.message,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final TextTheme textTheme;
  final String message;
  final void Function()? onTap;

  // final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      decoration: const BoxDecoration(
        color: LdColors.orangeWarning,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: size.width * 0.78,
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.report_problem_outlined,
                  color: LdColors.white,
                  size: 25,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      message,
                      style: textTheme.textGray.copyWith(
                        color: LdColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.close,
              color: LdColors.white,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
