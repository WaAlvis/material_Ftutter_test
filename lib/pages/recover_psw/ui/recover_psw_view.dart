import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/recover_psw/recover_psw_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';

part 'recover_psw_mobile.dart';

part 'recover_psw_web.dart';

class RecoverPswView extends StatelessWidget {
  const RecoverPswView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<RecoverPswViewModel>(
      create: (_) => RecoverPswViewModel(),
      builder: (BuildContext context, _) {
        return _RecoverPswBody(isBuy: isBuy);
      },
    );
  }
}

class _RecoverPswBody extends StatefulWidget {
  const _RecoverPswBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _RecoverPswBodyState createState() => _RecoverPswBodyState();
}

class _RecoverPswBodyState extends State<_RecoverPswBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController usuarioCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    usuarioCtrl.dispose();
    super.dispose();
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
                          passwordCtrl: passwordCtrl,
                          isBuy: widget.isBuy,
                        )
                      : _RecoverPswWebMobile(
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
