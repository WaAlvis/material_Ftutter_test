import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/iu/components/card_register.dart';
import 'package:localdaily/pages/register/iu/components/first_step_register.dart';
import 'package:localdaily/pages/register/iu/components/second_step_register.dart';
import 'package:localdaily/pages/register/iu/components/fourth_step_register.dart';
import 'package:localdaily/pages/register/iu/components/third_step_register.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
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
        return _RegisterBody();
      },
    );
  }
}

class _RegisterBody extends StatefulWidget {
  const _RegisterBody({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<_RegisterBody> {
  final GlobalKey<FormState> keyFirstForm = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController nickNameCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController firstLastNameCtrl = TextEditingController();
  final TextEditingController secondNameCtrl = TextEditingController();
  final TextEditingController secondLastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  // final TextEditingController dateBirthCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirrmPassCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();

    nickNameCtrl.dispose();
    firstNameCtrl.dispose();
    firstLastNameCtrl.dispose();
    secondNameCtrl.dispose();
    secondLastNameCtrl.dispose();
    phoneCtrl.dispose();
    // dateBirthCtrl.dispose();
    passwordCtrl.dispose();
    confirrmPassCtrl.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     context.read<HomeViewregisterModel>().onInit(context);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: maxWidth > 1024
                  ? _RegisterWeb(
                      keyForm: keyFirstForm,
                    )
                  : _RegisterMobile(
                      keyForm: keyFirstForm,
                      emailCtrl: emailCtrl,
                      nickNameCtrl: nickNameCtrl,
                      firstNameCtrl: firstNameCtrl,
                      firstLastNameCtrl: firstLastNameCtrl,
                      secondNameCtrl: secondNameCtrl,
                      secondLastNameCtrl: secondLastNameCtrl,
                      phoneCtrl: phoneCtrl,
                      dateBirthCtrl: viewModel.status. dateBirthCtrl,
                      passwordCtrl: passwordCtrl,
                      confirmPassCtrl: confirrmPassCtrl,
                    ),
            )
          ],
        );
      },
    );
  }
}
