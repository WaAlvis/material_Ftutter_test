import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

import '../app_theme.dart';

class LdFooter extends StatelessWidget {

  const LdFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Container(
      color: LdColors.black,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Servicios',
                style: textTheme.textWhite,
              ),
              const SizedBox(height: 15),
              Text(
                'Comprar',
                style: textTheme.textSmallWhite,
              ),
              const SizedBox(height: 10),
              Text(
                'Vender',
                style: textTheme.textSmallWhite,
              ),
              const SizedBox(height: 10),
              Text(
                'Instrucciones',
                style: textTheme.textSmallWhite,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Compañia',
                style: textTheme.textWhite,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.2,
                child: Text(
                  'Fugiat aliquip veniam in sunt. Id dolore in labore laborum amet. Cupidatat veniam tempor fugiat cillum et et consectetur quis non eiusmod laborum et do. Exercitation pariatur pariatur nulla occaecat laboris.',
                  style: textTheme.textSmallWhite,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Únase al boletin',
                style: textTheme.textWhite,
              ),
              const SizedBox(height: 15),
              Text(
                'Tu correo electrónico',
                style: textTheme.textSmallWhite,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 210,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color: LdColors.white,
                      ),
                      color: LdColors.white
                    ),
                    child: Text(
                      'Introduce tu correo electrónico',
                      style: textTheme.textGray.copyWith(
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: 120,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: LdColors.white,
                    ),
                    child: Text(
                      'Subscribirse',
                      style: textTheme.textSmallBlack,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
