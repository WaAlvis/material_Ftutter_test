import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_daily/commons/dly_colors.dart';
import 'package:mi_daily/commons/dly_icons.dart';
import 'package:mi_daily/generated/l10n.dart';

import '../../../../app_theme.dart';

class ProfileScreen extends StatefulWidget {

  final VoidCallback goHelp;
  final VoidCallback goSettings;
  final VoidCallback goTerms;

  const ProfileScreen(this.goHelp, this.goSettings, this.goTerms);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final I18n i18n = I18n.current;

    Widget buttonOption(String label, IconData icon, VoidCallback onTap){

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        child: MaterialButton(
          color: DlyColors.whiteGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    icon
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    label,
                    style: textTheme.buttonBlack.copyWith(
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_sharp
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: DlyColors.grayBg,
      appBar: AppBar(
        title: Text(i18n.profile),
        centerTitle: true,
        elevation: 0,
        backgroundColor: DlyColors.grayBg,
        leading: const SizedBox.shrink()
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              width: size.width * 0.85,
                              decoration: BoxDecoration(
                                color: DlyColors.gray,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '+57 3001112202',
                                    style: textTheme.titleWhite.copyWith(
                                      fontSize: 20
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    i18n.profileId('000001'),
                                    style: textTheme.labelWhite,
                                    textAlign: TextAlign.start,
                                  ),
                                  // TODO: Esta sección se omite para esta versión
                                  /*SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Correo:',
                                        style: textTheme.textTapWhite.copyWith(
                                            fontSize: 12,
                                            color: DlyColors.white.withOpacity(0.8)
                                        ),
                                      ),
                                      Text(
                                        'nombre@correo.com',
                                        style: textTheme.subtitleWhite.copyWith(
                                            fontSize: 14
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                            color: DlyColors.black,
                                          )
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Referidos:',
                                        style: textTheme.textTapWhite.copyWith(
                                            fontSize: 12,
                                            color: DlyColors.white.withOpacity(0.8)
                                        ),
                                      ),
                                      Text(
                                        'Id. 0000002',
                                        style: textTheme.subtitleWhite.copyWith(
                                            fontSize: 14
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '',
                                        style: textTheme.textTapWhite.copyWith(
                                            fontSize: 12,
                                            color: DlyColors.white.withOpacity(0.8)
                                        ),
                                      ),
                                      Text(
                                        'Id. 0000003',
                                        style: textTheme.subtitleWhite.copyWith(
                                            fontSize: 14
                                        ),
                                      )
                                    ],
                                  ),*/
                                  const SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        buttonOption(i18n.help, DlyIcons.helpOutline, widget.goHelp),
                        buttonOption(i18n.settings, DlyIcons.configuration, widget.goSettings),
                        buttonOption(i18n.termsConditions, DlyIcons.terms, widget.goTerms)
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                      child: InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                DlyIcons.power,
                                color: DlyColors.white,
                                size: 33,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  i18n.logOut,
                                  style: textTheme.subtitleWhite.copyWith(
                                    fontSize: 17
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
          );
        }
      )
    );
  }
}