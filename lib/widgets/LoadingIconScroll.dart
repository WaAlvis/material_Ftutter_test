import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

class LoadingIconScroll extends StatelessWidget {
  const LoadingIconScroll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: LdColors.blackText.withOpacity(0.9),
      ),
      child: const CircularProgressIndicator(
        color: LdColors.orangePrimary,
      ),
    );
  }
}
