import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/change_password/change_password_view_model.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
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

  @override
  void initState() {
    // final HistoryViewModel viewModel = context.read<HistoryViewModel>();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ChangePasswordViewModel>().onInit();
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
    currentPswCtrl.dispose();
    newPswCtrl.dispose();
    againNewPswCtrl.dispose();
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
                  ? ChangePasswordWeb(
                      keyForm: keyForm,
                    )
                  : ChangePasswordMobile(
                      keyForm: keyForm,
                      currentPswCtrl: currentPswCtrl,
                      newPswCtrl: newPswCtrl,
                      againPswCtrl: againNewPswCtrl,
                      // scrollCtrl: _scrollCtrl,
                    ),
            )
          ],
        );
      },
    );
  }
}
