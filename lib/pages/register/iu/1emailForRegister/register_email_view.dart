import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/iu/components/card_register.dart';
import 'package:localdaily/pages/register/iu/register_view_model.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_app_bar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'register_email_mobile.dart';
part 'register_email_web.dart';

class RegisterEmailView extends StatelessWidget {
  const RegisterEmailView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<RegisterViewModel>(
      create: (_) => RegisterViewModel(),
      builder: (BuildContext context, _) {
        return _RegisterBody(isBuy: isBuy);

      },
    );
  }
}

class _RegisterBody extends StatefulWidget {
  const _RegisterBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<_RegisterBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel viewModel =
        context.watch<RegisterViewModel>();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: maxWidth > 1024
                  ? _RegisterWeb(
                      keyForm: keyForm,
                      passwordCtrl: passwordCtrl,
                      isBuy: widget.isBuy,
                    )
                  : _RegisterMobile(
                      keyForm: keyForm,
                    ),
            )
          ],
        );
      },
    );
  }
}
