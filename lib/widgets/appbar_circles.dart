import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/quarter_circle.dart';

class AppbarCircles extends StatelessWidget {
  const AppbarCircles({Key? key, required this.hAppbar, this.content})
      : super(key: key);
  final double hAppbar;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: LdColors.blackBackground,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          // Esto es el circulo, ideal volverlo widget
          Positioned(
            right: 0,
            child: SizedBox(
              // El tamaño depende del tamaño de la pantalla
              width: (size.width) / 4,
              height: (size.width) / 4,
              child: QuarterCircle(
                circleAlignment: CircleAlignment.bottomRight,
                color: LdColors.grayLight.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SizedBox(
              width: (size.width) * 2 / 4,
              height: (size.width) * 2 / 4,
              child: QuarterCircle(
                circleAlignment: CircleAlignment.bottomRight,
                color: LdColors.grayLight.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SizedBox(
              width: (size.width) * 3 / 4,
              height: (size.width) * 3 / 4,
              child: QuarterCircle(
                circleAlignment: CircleAlignment.bottomRight,
                color: LdColors.grayLight.withOpacity(0.05),
              ),
            ),
          ),
          SizedBox(
            height: hAppbar,
          ),
          if (content != null) content!
        ],
      ),
    );
  }
}
