import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/delete_account/delete_account_effect.dart';
import 'package:localdaily/pages/delete_account/delete_account_view_model.dart';

import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/app_bar_bigger.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';

part 'delete_account_mobile.dart';
part 'delete_account_web.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteAccountViewModel>(
      create: (_) => DeleteAccountViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _deleteAccountBody(),
        );
      },
    );
  }
}

class _deleteAccountBody extends StatefulWidget {
  const _deleteAccountBody({
    Key? key,
  }) : super(key: key);

  @override
  _deleteAccountBodyState createState() => _deleteAccountBodyState();
}

class _deleteAccountBodyState extends State<_deleteAccountBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  final TextEditingController pswDeleteAccountCtrl = TextEditingController();
  late StreamSubscription<DeleteAccountEffect> _effectSubscription;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<DeleteAccountViewModel>().onInit();
    });
    final DeleteAccountViewModel viewModel = context.read<DeleteAccountViewModel>();

    _effectSubscription = viewModel.effects.listen((DeleteAccountEffect event) {
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
      }else if (event is DialogConfirmDeleteAccount) {
        LdDialog.buildDenseAlertDialog(
          context,
          image: LdAssets.loginIdentity,
          title: 'Eliminacion de cuenta',
          message:
                    'Este proceso eliminara de manera permanente su cuenta de usuario y no podra ser recuperada.\n\n ¿Desea eliminar su cuenta?',
          btnText: 'Eliminar cuenta',
          onTap: () => viewModel.deleteAccountCloseDialog(context ),
          btnTextSecondary: 'Cancelar',
          onTapSecondary: () => viewModel.closeDialog(context)
        );
      }


    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pswDeleteAccountCtrl.dispose();
    _effectSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final DeleteAccountViewModel viewModel = context.watch<DeleteAccountViewModel>();
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
                      ? DeleteAccountWeb(
                          keyForm: keyForm,
                        )
                      : DeleteAccountMobile(
                          keyForm: keyForm,
                          pswDeleteAccountCtrl: pswDeleteAccountCtrl,

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
