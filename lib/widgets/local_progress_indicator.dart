import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

class IdtProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: LdColors.black.withOpacity(0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
    );
  }
}
