import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/appbar_circles.dart';

class AppBarBigger extends StatelessWidget {
  final String title;
  final double hAppbar;
  final TextTheme textTheme;
  final void Function()? actionBack;

  const AppBarBigger({
    Key? key,
    required this.hAppbar,
    required this.textTheme,
    required this.title,
    this.actionBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double widthScreen =    MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        // Esto es el circulo, ideal volverlo widget
        AppbarCircles(hAppbar: hAppbar),
        SizedBox(
          // width: widthScreen,
          height: hAppbar,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: actionBack ?? () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: LdColors.white,
                  ),
                ),
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: textTheme.textBigWhite,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
