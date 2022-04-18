import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/recover_psw/recover_psw_effect.dart';
import 'package:localdaily/pages/recover_psw/recover_psw_view_model.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';

part 'recover_psw_mobile.dart';

part 'recover_psw_web.dart';

class RecoverPswView extends StatelessWidget {
  const RecoverPswView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<RecoverPswViewModel>(
      create: (_) => RecoverPswViewModel(),
      builder: (BuildContext context, _) {
        return _RecoverPswBody();
      },
    );
  }
}

class _RecoverPswBody extends StatefulWidget {
  const _RecoverPswBody({
    Key? key,
  }) : super(key: key);

  @override
  _RecoverPswBodyState createState() => _RecoverPswBodyState();
}

class _RecoverPswBodyState extends State<_RecoverPswBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController emailForRecoverCtrl = TextEditingController();

  late StreamSubscription<RecoverPswEffect> _effectSubscription;

  @override
  void dispose() {
    emailForRecoverCtrl.dispose();
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    final RecoverPswViewModel viewModel = context.read<RecoverPswViewModel>();

    _effectSubscription =
        viewModel.effects.listen((RecoverPswEffect event) async {
      if (event is ShowSnackbarConnectivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ShowSnackbarRecoverPswEffect) {
        LdSnackbar.buildSuccessSnackbar(context, 'el otro snack', 2);
        LdSnackbar.buildSnackbar(
          context,
          'nueva contraseña enviada',
          2,
        );
      } else if (event is ShowSnackbarErrorEmailEffect) {
        LdSnackbar.buildErrorSnackbar(
          context,
          event.message,
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RecoverPswViewModel viewModel = context.watch<RecoverPswViewModel>();
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
                      ? _RecoverPswWeb(
                          keyForm: keyForm,
                          emailForRecoverCtrl: emailForRecoverCtrl,
                        )
                      : _RecoverPswWebMobile(
                          keyForm: keyForm,
                          emailForRecoverCtrl: emailForRecoverCtrl,
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
