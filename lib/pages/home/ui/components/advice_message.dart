import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/widgets/primary_button.dart';

class AdviceMessage extends StatelessWidget {
  const AdviceMessage({
    Key? key,
    required this.imageName,
    required this.title,
    required this.description,
    this.btnText,
    this.onPressed,
  }) : super(key: key);

  final String imageName;
  final String title;
  final String description;
  final String? btnText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SvgPicture.asset(imageName),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: textTheme.textBigBlack,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: size.width * .7,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: textTheme.textSmallBlack,
                  ),
                ),
              ],
            ),
          ),
          if (onPressed != null)
            PrimaryButtonCustom(
              btnText ?? '',
              onPressed: onPressed,
            ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
