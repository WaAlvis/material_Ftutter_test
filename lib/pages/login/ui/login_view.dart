import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/login/login_view_model.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_app_bar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:provider/provider.dart';

part 'components/card_login.dart';
part 'login_mobile.dart';
part 'login_web.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      builder: (BuildContext context, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: LdColors.blackBackground,
            leading: const Icon(
              Icons.arrow_back_ios,
              color: LdColors.white,
            ),
            title: Text(
              'Iniciar sesión',
              style: textTheme.textSmallWhite.copyWith(color: LdColors.white),
            ),
            elevation: 0, // 2
          ),
          backgroundColor: LdColors.white,
          body: _LoginBody(isBuy: isBuy),
        );
      },
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = context.watch<LoginViewModel>();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: maxWidth > 1024
                  ? _LoginWeb(
                      keyForm: keyForm,
                      passwordCtrl: passwordCtrl,
                      isBuy: widget.isBuy,
                    )
                  : _LoginMobile(
                      keyForm: keyForm,
                      passwordCtrl: passwordCtrl,
                    ),
            )
          ],
        );
      },
    );
  }
}
