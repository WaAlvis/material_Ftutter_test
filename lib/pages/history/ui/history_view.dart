import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/history/history_view_model.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';
import 'string_extension.dart';

part 'history_mobile.dart';

part 'history_web.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key, this.operations}) : super(key: key);

  final List<DataUserAdvertisement>? operations;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HistoryViewModel>(
      create: (_) => HistoryViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        operations,
      ),
      builder: (BuildContext context, _) {
        return Scaffold(
          backgroundColor: LdColors.white,
          body: _HistoryBody(
            operations: operations!,
          ),
        );
      },
    );
  }
}

class _HistoryBody extends StatefulWidget {
  const _HistoryBody({Key? key, required this.operations}) : super(key: key);

  final List<DataUserAdvertisement> operations;

  @override
  _HistoryBodyState createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<_HistoryBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    // final HistoryViewModel viewModel = context.read<HistoryViewModel>();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<HistoryViewModel>().onInit(_scrollCtrl);
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
    _scrollCtrl.dispose();
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
                  ? HistoryWeb(
                      keyForm: keyForm,
                    )
                  : HistoryMobile(
                      keyForm: keyForm,
                      scrollCtrl: _scrollCtrl,
                      operations: widget.operations,
                    ),
            )
          ],
        );
      },
    );
  }
}
