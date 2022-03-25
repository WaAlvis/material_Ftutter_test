import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/settings/settings_view_model.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'settings_mobile.dart';

part 'settings_web.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (_) => SettingsViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _SettingsBody(),
        );
      },
    );
  }
}

class _SettingsBody extends StatefulWidget {
  const _SettingsBody({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<_SettingsBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  // final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    // final HistoryViewModel viewModel = context.read<HistoryViewModel>();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<SettingsViewModel>().onInit();
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
                  ? SettingsWeb(
                      keyForm: keyForm,
                    )
                  : SettingsMobile(
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
