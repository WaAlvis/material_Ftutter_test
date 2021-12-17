import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/primary_button.dart';

import '../app_theme.dart';

class LdAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onBackSignup;
  final Function(BuildContext)? goLogin;
  final bool withBackIcon;
  final bool withText;
  final bool withButton;
  final Color? color;

  const LdAppbar({
    this.title,
    this.onBackSignup,
    this.withBackIcon = true,
    this.withText = false,
    this.withButton = false,
    this.color,
    this.goLogin,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size.infinite,
      child: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: title != null
              ? Text(
                  title!,
                  style: textTheme.textBigWhite,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset(
                      LdAssets.logo,
                      height: 30,
                    ),
                    if (withButton)
                      PrimaryButtonCustom(
                        'Iniciar sesión',
                        colorText: LdColors.white,
                        colorButton: LdColors.whiteGray.withOpacity(0.5),
                        width: size.width / 4,
                        height: 35,
                        onPressed: () => goLogin!(context),
                      ),
                  ],
                ),
        ),
        leading: withBackIcon
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: LdColors.white,
                  size: 32,
                ),
                onPressed: onBackSignup,
              )
            : null,
      ),
    );
  }
}
