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
          const CircleDecoration(quarter: 1, color: LdColors.grayLight),
          const CircleDecoration(quarter: 2, color: LdColors.grayLight),
          const CircleDecoration(quarter: 3, color: LdColors.grayLight),
          SizedBox(
            height: hAppbar,
          ),
          if (content != null) content!
        ],
      ),
    );
  }
}

class CircleDecoration extends StatelessWidget {
  const CircleDecoration({
    Key? key,
    required this.quarter,
    required this.color,
  }) : super(key: key);
  final int quarter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
      child: SizedBox(
        // El tamaño depende del tamaño de la pantalla
        width: (size.width) * quarter / 4,
        height: (size.width) * quarter / 4,
        child: QuarterCircle(
          circleAlignment: CircleAlignment.bottomRight,
          color: color.withOpacity(0.05),
        ),
      ),
    );
  }
}
