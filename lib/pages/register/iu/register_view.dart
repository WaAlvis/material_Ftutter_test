import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/register/iu/components/card_register.dart';
import 'package:localdaily/pages/register/iu/components/step_1_email_register.dart';
import 'package:localdaily/pages/register/iu/components/step_2_msj_email.dart';
import 'package:localdaily/pages/register/iu/components/step_3_validate_pin.dart';
import 'package:localdaily/pages/register/iu/components/step_4_account_data.dart';
import 'package:localdaily/pages/register/iu/components/step_5_ personal_data.dart';
import 'package:localdaily/pages/register/iu/components/step_6_%20restore_wallet.dart';
import 'package:localdaily/pages/register/register_status.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'register_mobile.dart';
part 'register_web.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<RegisterViewModel>(
      create: (_) => RegisterViewModel(),
      builder: (BuildContext context, _) {
        return const RegisterBody();
      },
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({
    Key? key,
  }) : super(key: key);

  @override
  RegisterBodyState createState() => RegisterBodyState();
}

class RegisterBodyState extends State<RegisterBody> {
  // final GlobalKey<FormState> keyFirstForm = GlobalKey<FormState>();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController nickNameCtrl = TextEditingController();
  final TextEditingController phraseCtrl = TextEditingController();
  final TextEditingController namesCtrl = TextEditingController();
  final TextEditingController surnamesCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();
  final TextEditingController codePinCtrl = TextEditingController();
  final TextEditingController addressWallet = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    nickNameCtrl.dispose();
    namesCtrl.dispose();
    surnamesCtrl.dispose();
    phoneCtrl.dispose();
    phraseCtrl.dispose();
    passwordCtrl.dispose();
    confirmPassCtrl.dispose();
    codePinCtrl.dispose();
    addressWallet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : const SizedBox.shrink();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return Stack(
          children: <Widget>[
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: maxWidth > 1024
                      ? RegisterWeb(
                          keyForm: keyForm,
                        )
                      : RegisterMobile(
                          keyForm: keyForm,
                          emailCtrl: emailCtrl,
                          nickNameCtrl: nickNameCtrl,
                          namesCtrl: namesCtrl,
                          surnamesCtrl: surnamesCtrl,
                          phoneCtrl: phoneCtrl,
                          dateBirthCtrl: viewModel.status.dateBirthCtrl,
                          passwordCtrl: passwordCtrl,
                          confirmPassCtrl: confirmPassCtrl,
                          codePinCtrl: codePinCtrl,
                          addressWalletCtrl: addressWallet,
                          phraseCtrl: phraseCtrl,
                        ),
                )
              ],
            ),
            loading,
          ],
        );
      },
    );
  }
}
