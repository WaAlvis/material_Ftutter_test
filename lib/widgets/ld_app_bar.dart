import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';

import '../app_theme.dart';

class LdAppbar extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final Function()? onBackSignup;

  const LdAppbar(this.title, {this.onBackSignup});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return PreferredSize(
      preferredSize: Size.infinite,
      child: AppBar(
        backgroundColor: LdColors.black,
        centerTitle: true,
        leading: const SizedBox.shrink(),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: <Widget>[
              const Expanded(
                flex: 3,
                child: SizedBox(width: 120),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // locator<LdRouter>()
                    TextButton(
                      onPressed: ()=> locator<LdRouter>().goBuy(context),
                      child: Text(
                        'Comprar',
                        style: textTheme.textWhite,
                      ),
                    ),
                    TextButton(
                      onPressed: ()=> locator<LdRouter>().goSell(context),
                      child: Text(
                        'Vender',
                        style: textTheme.textWhite,
                      ),
                    ),
                    Text(
                      'Instrucciones',
                      style: textTheme.textWhite,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: LdColors.white,
                            ),
                          ),
                          child: TextButton(
                            onPressed: ()=> locator<LdRouter>().goLogin(context),
                            child: Text(
                              'Iniciar sesión',
                              style: textTheme.textWhite,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 150,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: LdColors.white,
                          ),
                          child: TextButton(
                            onPressed: ()=> locator<LdRouter>().goEmailRegister(context),
                            child: Text(
                              'Regístrate',
                              style: textTheme.textBlack,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
