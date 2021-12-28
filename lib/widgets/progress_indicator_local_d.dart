import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/quarter_circle.dart';

class ProgressIndicatorLocalD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      color: LdColors.blackBackground,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,

        children: [
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
              width: (size.width ) * 2 / 4,
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
          Column(
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
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
