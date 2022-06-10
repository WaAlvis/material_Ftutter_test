import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_support/detail_support_effect.dart';
import 'package:localdaily/pages/detail_support/detail_support_view_model.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'detail_support_mobile.dart';

part 'detail_support_web.dart';

class DetailSupportView extends StatelessWidget {
  const DetailSupportView({
    Key? key,
    required this.advertisement,
  }) : super(key: key);

  final BodyContactSupport advertisement;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailSupportViewModel>(
      create: (_) => DetailSupportViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        advertisement,
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _DetailSupportBody(),
        );
      },
    );
  }
}

class _DetailSupportBody extends StatefulWidget {
  const _DetailSupportBody({
    Key? key,
  }) : super(key: key);

  @override
  _DetailSupportBodyState createState() => _DetailSupportBodyState();
}

class _DetailSupportBodyState extends State<_DetailSupportBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late StreamSubscription<DetailSupportEffect> _effectSubscription;

  @override
  void initState() {
    // final HistoryViewModel viewModel = context.read<HistoryViewModel>();
    final DetailSupportViewModel viewModel =
        context.read<DetailSupportViewModel>();

    _effectSubscription = viewModel.effects.listen((DetailSupportEffect event) {
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
                  ? DetailSupportWeb(
                      keyForm: keyForm,
                    )
                  : DetailSupportMobile(
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
