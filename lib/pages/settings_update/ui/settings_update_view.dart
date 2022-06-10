import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings_update/settings_update_effect.dart';
import 'package:localdaily/pages/settings_update/settings_update_view_model.dart';

import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'settings_update_mobile.dart';

part 'settings_update_web.dart';

class SettingsUpdateView extends StatelessWidget {
  const SettingsUpdateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsUpdateViewModel>(
      create: (_) => SettingsUpdateViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _SettingsUpdateBody(),
        );
      },
    );
  }
}

class _SettingsUpdateBody extends StatefulWidget {
  const _SettingsUpdateBody({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsUpdateBodyState createState() => _SettingsUpdateBodyState();
}

class _SettingsUpdateBodyState extends State<_SettingsUpdateBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late StreamSubscription<SettingsUpdateEffect> _effectSubscription;

  @override
  void initState() {
    // final HistoryViewModel viewModel = context.read<HistoryViewModel>();
    final SettingsUpdateViewModel viewModel =
        context.read<SettingsUpdateViewModel>();

    _effectSubscription =
        viewModel.effects.listen((SettingsUpdateEffect event) {
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
                  ? SettingsUpdateWeb(
                      keyForm: keyForm,
                    )
                  : SettingsUpdateMobile(
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
