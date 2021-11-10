import 'package:flutter/material.dart';
import 'package:localdaily/api/repository/interactor/api_interactor.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/validate_email/validate_email_view_model.dart';
import 'package:localdaily/widgets/ld_app_bar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:provider/provider.dart';

part 'components/card_register.dart';
part 'validate_email_mobile.dart';
part 'validate_email_web.dart';

class ValidateEmailView extends StatelessWidget {
  const ValidateEmailView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ValidateEmailViewModel>(
      create: (_) => ValidateEmailViewModel(
          locator<LdRouter>(),
          locator<ApiInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return Scaffold(
          backgroundColor: LdColors.white,
          body: _ValidateEmailBody(isBuy: isBuy),
        );
      },
    );
  }
}

class _ValidateEmailBody extends StatefulWidget {

  const _ValidateEmailBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _ValidateEmailBodyState createState() => _ValidateEmailBodyState();
}

class _ValidateEmailBodyState extends State<_ValidateEmailBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ValidateEmailViewModel viewModel = context.watch<ValidateEmailViewModel>();

    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;

      return CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: maxWidth > 1024
              ? _ValidateEmailWeb(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                  isBuy: widget.isBuy
                )
              : _ValidateEmailMobile(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                ),
          )
        ],
      );
    },);
  }
}
