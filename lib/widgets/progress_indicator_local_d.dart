import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/appbar_circles.dart';

class ProgressIndicatorLocalD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AppbarCircles(
      hAppbar: 0,
      content: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  child: CircularProgressIndicator(
                    color: LdColors.orangePrimary,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Cargando...',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: LdColors.white),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            LdAssets.logoWhiteWhite,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
