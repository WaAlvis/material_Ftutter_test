import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/profile_seller/profile_seller_effect.dart';
import 'package:localdaily/pages/profile_seller/profile_seller_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/user_data_home.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';

// part 'components/card_login.dart';

part 'profile_seller_mobile.dart';

part 'profile_seller_web.dart';

class ProfileSellerView extends StatelessWidget {
  const ProfileSellerView({Key? key, this.isBuy = false})
      : super(key: key);

  final bool isBuy;
  // final UserDataHome user;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<ProfileSellerViewModel>(
      create: (_) => ProfileSellerViewModel(),
      builder: (BuildContext context, _) {
        return _ProfileSellerBody( isBuy: isBuy);
      },
    );
  }
}

class _ProfileSellerBody extends StatefulWidget {
  const _ProfileSellerBody( {Key? key, required this.isBuy})
      : super(key: key);

  final bool isBuy;

  @override
  _ProfileSellerBodyState createState() => _ProfileSellerBodyState();
}

class _ProfileSellerBodyState extends State<_ProfileSellerBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController usuarioCtrl = TextEditingController();

  late StreamSubscription<ProfileSellerEffect> _effectSubscription;

  @override
  void dispose() {
    passwordCtrl.dispose();
    _effectSubscription.cancel();
    usuarioCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final ProfileSellerViewModel viewModel =
        context.read<ProfileSellerViewModel>();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ProfileSellerViewModel>().onInit();
    });

    _effectSubscription =
        viewModel.effects.listen((ProfileSellerEffect event) async {
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
    final ProfileSellerViewModel viewModel =
        context.watch<ProfileSellerViewModel>();
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
                      ? _ProfileSellerWeb(
                          keyForm: keyForm,
                          passwordCtrl: passwordCtrl,
                          isBuy: widget.isBuy,
                        )
                      : _ProfileSellerMobile(keyForm: keyForm,
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
