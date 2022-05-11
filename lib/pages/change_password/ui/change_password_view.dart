import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/change_password/change_password_effect.dart';
import 'package:localdaily/pages/change_password/change_password_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/list_checks_required_psw.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'change_password_mobile.dart';

part 'change_password_web.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordViewModel>(
      create: (_) => ChangePasswordViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _ChangePasswordBody(),
        );
      },
    );
  }
}

class _ChangePasswordBody extends StatefulWidget {
  const _ChangePasswordBody({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePasswordBodyState createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<_ChangePasswordBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  final TextEditingController currentPswCtrl = TextEditingController();
  final TextEditingController newPswCtrl = TextEditingController();
  final TextEditingController againNewPswCtrl = TextEditingController();
  late StreamSubscription<ChangePswEffect> _effectSubscription;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ChangePasswordViewModel>().onInit();
    });
    final ChangePasswordViewModel viewModel =
        context.read<ChangePasswordViewModel>();

    _effectSubscription = viewModel.effects.listen((ChangePswEffect event) {
      if (event is ShowSnackbarConnectivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ShowSuccessSnackbar) {
        LdSnackbar.buildSuccessSnackbar(
          context,
          event.message,
        );
      } else if (event is ShowWarningSnackbar) {
        LdSnackbar.buildSnackbar(
          context,
          event.message,
        );
      } else if (event is ShowErrorSnackbar) {
        LdSnackbar.buildErrorSnackbar(
          context,
          event.message,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    currentPswCtrl.dispose();
    newPswCtrl.dispose();
    againNewPswCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChangePasswordViewModel viewModel =
        context.watch<ChangePasswordViewModel>();
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
                      ? ChangePasswordWeb(
                          keyForm: keyForm,
                        )
                      : ChangePasswordMobile(
                          keyForm: keyForm,
                          currentPswCtrl: currentPswCtrl,
                          newPswCtrl: newPswCtrl,
                          againNewPswCtrl: againNewPswCtrl,
                          // scrollCtrl: _scrollCtrl,
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
