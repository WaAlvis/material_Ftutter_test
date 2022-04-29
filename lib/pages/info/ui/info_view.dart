import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/primary_button.dart';

part '../info_models.dart';
// Components
part 'info_mobile.dart';
part 'info_web.dart';

class InfoView extends StatefulWidget {
  const InfoView({
    Key? key,
    this.arguments,
  }) : super(key: key);

  final InfoViewArguments? arguments;

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return Stack(
          children: <Widget>[
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child:
                      maxWidth > 1024 ? const _InfoWeb() : _InfoMobile(arguments: widget.arguments!),
                )
              ],
            ),
            //loading,
          ],
        );
      },
    );
  }
}
