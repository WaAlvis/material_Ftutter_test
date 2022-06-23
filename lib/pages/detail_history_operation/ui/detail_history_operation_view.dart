import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_history_operation/detail_history_operation_effect.dart';
import 'package:localdaily/pages/detail_history_operation/detail_history_operation_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/app_bar_bigger.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'detail_history_operation_mobile.dart';

part 'detail_history_opertarion_web.dart';

class DetailHistoryOperationView extends StatelessWidget {
  const DetailHistoryOperationView({
    Key? key,
    this.item,
    this.isBuying,
  }) : super(key: key);

  final bool? isBuying;
  final DataUserAdvertisement? item;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailHistoryOperationViewModel>(
      create: (_) => DetailHistoryOperationViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        isBuying!
            ? item!.advertisement.advertisementUserInteraction!.first.idUser
            : item!.advertisement.idUserPublish,
      ),
      builder: (BuildContext context, _) {
        return Scaffold(
          backgroundColor: LdColors.white,
          body: _DetailHistoryOperationBody(
            item!,
          ),
        );
      },
    );
  }
}

class _DetailHistoryOperationBody extends StatefulWidget {
  const _DetailHistoryOperationBody(
    this.item, {
    Key? key,
  }) : super(key: key);

  final DataUserAdvertisement item;

  @override
  _DetailHistoryOperationBodyState createState() =>
      _DetailHistoryOperationBodyState();
}

class _DetailHistoryOperationBodyState
    extends State<_DetailHistoryOperationBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late StreamSubscription<DetailHistoryOperationEffect> _effectSubscription;

  @override
  void initState() {
    final DetailHistoryOperationViewModel viewModel =
        context.read<DetailHistoryOperationViewModel>();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => viewModel.onInit(context),
    );

    _effectSubscription =
        viewModel.effects.listen((DetailHistoryOperationEffect event) async {
      if (event is ShowSnackbarConnectivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ShowErrorSnackbar) {
        LdSnackbar.buildErrorSnackbar(context, event.message);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _effectSubscription.cancel();
    super.dispose();
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
                  ? DetailHistoryOperationWeb(
                      keyForm: keyForm,
                    )
                  : DetailHistoryOperationMobile(
                      keyForm: keyForm,
                      item: widget.item,
                      // scrollCtrl: _scrollCtrl,
                    ),
            )
          ],
        );
      },
    );
  }
}
