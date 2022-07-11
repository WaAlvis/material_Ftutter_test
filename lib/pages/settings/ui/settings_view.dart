import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings/settings_effect.dart';
import 'package:localdaily/pages/settings/settings_view_model.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/app_bar_bigger.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'settings_mobile.dart';

part 'settings_web.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (_) => SettingsViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _SettingsBody(),
        );
      },
    );
  }
}

class _SettingsBody extends StatefulWidget {
  const _SettingsBody({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<_SettingsBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late StreamSubscription<SettingEffect> _effectSubscription;

  @override
  void initState() {
    // final HistoryViewModel viewModel = context.read<HistoryViewModel>();
    final SettingsViewModel viewModel = context.read<SettingsViewModel>();

    _effectSubscription = viewModel.effects.listen((SettingEffect event) {
      if (event is ShowSnackbarConnectivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _scrollCtrl.dispose();
    _effectSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: maxWidth > 1024
                  ? SettingsWeb(
                      keyForm: keyForm,
                    )
                  : SettingsMobile(
                      keyForm: keyForm,
                      // scrollCtrl: _scrollCtrl,
                    ),
            )
          ],
        );
      },
    );
  }
}
