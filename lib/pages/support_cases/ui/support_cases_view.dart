import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/ui/components/advice_message.dart';
import 'package:localdaily/pages/support_cases/support_cases_view_model.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/services/models/contact_support/support_status/result_support_status.dart';
import 'package:localdaily/view_model.dart';
import 'package:localdaily/widgets/app_bar_bigger.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'support_cases_mobile.dart';

class SupportCasesView extends StatelessWidget {
  const SupportCasesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SupportCasesViewModel>(
      create: (BuildContext context) => SupportCasesViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      child: const SupportCasesBody(),
    );
  }
}

class SupportCasesBody extends StatefulWidget {
  const SupportCasesBody({Key? key}) : super(key: key);

  @override
  State<SupportCasesBody> createState() => _SupportCasesBodyState();
}

class _SupportCasesBodyState extends State<SupportCasesBody> {
  final ScrollController _supportScrollCtrl = ScrollController();

  @override
  void initState() {
    final SupportCasesViewModel viewModel =
        context.read<SupportCasesViewModel>();
    final DataUserProvider userProvider = context.read<DataUserProvider>();

    _supportScrollCtrl.addListener(() {
      if (_supportScrollCtrl.position.pixels >
              _supportScrollCtrl.position.maxScrollExtent &&
          !viewModel.status.isLoading) {
        if (_supportScrollCtrl.position.maxScrollExtent != 0 &&
            viewModel.status.resultSupportCases.data.length !=
                viewModel.status.resultSupportCases.totalItems) {
          _supportScrollCtrl.jumpTo(
            _supportScrollCtrl.position.maxScrollExtent,
          );
        }

        viewModel
            .getData(
          userProvider.getDataUserLogged?.id ?? '',
          context,
          isPagination: true,
        )
            .then(
          (bool? value) {
            if (_supportScrollCtrl.position.maxScrollExtent != 0 &&
                value == null) {
              _supportScrollCtrl.animateTo(
                _supportScrollCtrl.position.maxScrollExtent + 150,
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
              );
            }
          },
        );
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      viewModel.onInit(userProvider.getDataUserLogged!.id , context);
    });

    super.initState();
  }

  @override
  void dispose() {
    _supportScrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: _SupportCasesMobile(supportScrollCtrl: _supportScrollCtrl),
            )
          ],
        );
      },
    );
  }
}
