import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_history_operation/detail_history_operation_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
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
    // this.isBuying,
  }) : super(key: key);

  // final bool? isBuying;
  final DataUserAdvertisement? item;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailHistoryOperationViewModel>(
      create: (_) => DetailHistoryOperationViewModel(
          locator<LdRouter>(),
          locator<ServiceInteractor>(),
          item!.advertisement.advertisementUserInteraction!.first.idUser
          // dataUserAdvertisement
          //     .advertisement.advertisementUserInteraction!.first.idUser,
          // isBuying: isBuying!,
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

  // final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    // final HistoryViewModel viewModel = context.read<HistoryViewModel>();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<DetailHistoryOperationViewModel>().onInit();
    });
    super.initState();
    // _scrollCtrl.addListener(() {
    //   if (_scrollCtrl.position.pixels >= _scrollCtrl.position.maxScrollExtent &&
    //       !viewModel.status.isLoadingHistory) {
    //     print('Get Data Historial');
    //     viewModel.mockFetch();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // _scrollCtrl.dispose();
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
