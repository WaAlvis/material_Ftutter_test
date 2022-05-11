import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/login/login_effect.dart';
import 'package:localdaily/pages/login/login_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';


part 'login_mobile.dart';

part 'login_web.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      builder: (BuildContext context, _) {
        return _LoginBody(isBuy: isBuy);
      },
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController usuarioCtrl = TextEditingController();

  late StreamSubscription<LoginEffect> _effectSubscription;

  @override
  void dispose() {
    passwordCtrl.dispose();
    usuarioCtrl.dispose();
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    final LoginViewModel viewModel = context.read<LoginViewModel>();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<LoginViewModel>().onInit();
    });

    _effectSubscription = viewModel.effects.listen((LoginEffect event) async {
      if (event is ShowSnackbarConnectivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ShowErrorSnackbar) {
        LdSnackbar.buildSnackbar(
          context,
          event.message,
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : const SizedBox.shrink();

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
                  child: maxWidth > 1024
                      ? _LoginWeb(
                          keyForm: keyForm,
                          passwordCtrl: passwordCtrl,
                          isBuy: widget.isBuy,
                        )
                      : _LoginMobile(
                          keyForm: keyForm,
                          passwordCtrl: passwordCtrl,
                          userCtrl: usuarioCtrl,
                        ),
                )
              ],
            ),
            loading,
          ],
        );
      },
    );
  }
}
