import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/iu/components/card_register.dart';
import 'package:localdaily/pages/register/iu/register_view_model.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/_app_bar_others.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:provider/provider.dart';

part 'personal_info_register_mobile.dart';

part 'personal_info_register_web.dart';

class PersonalInfoRegisterView extends StatelessWidget {
  const PersonalInfoRegisterView({Key? key, this.isBuy = false})
      : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<RegisterViewModel>(
      create: (_) => RegisterViewModel(),
      builder: (BuildContext context, _) {
        return Scaffold(
          backgroundColor: LdColors.white,
          appBar: AppBar(
            backgroundColor: LdColors.blackBackground,
            leading: const Icon(
              Icons.arrow_back_ios,
              color: LdColors.white,
            ),
            title: Text(
              'Crear cuenta',
              style: textTheme.textSmallWhite.copyWith(color: LdColors.white),
            ),
            elevation: 0, // 2
          ),
          body: _PersonalInfoRegisterBody(isBuy: isBuy),
        );
      },
    );
  }
}

class _PersonalInfoRegisterBody extends StatefulWidget {
  const _PersonalInfoRegisterBody({Key? key, required this.isBuy})
      : super(key: key);

  final bool isBuy;

  @override
  _PersonalInfoRegisterBodyState createState() =>
      _PersonalInfoRegisterBodyState();
}

class _PersonalInfoRegisterBodyState extends State<_PersonalInfoRegisterBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  final TextEditingController nickNameCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController firstLastNameCtrl = TextEditingController();
  final TextEditingController secondNameCtrl = TextEditingController();
  final TextEditingController secondLastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController dateBirthCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirrmPassCtrl = TextEditingController();

  @override
  void dispose() {
    nickNameCtrl.dispose();
    firstNameCtrl.dispose();
    firstLastNameCtrl.dispose();
    secondNameCtrl.dispose();
    secondLastNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    dateBirthCtrl.dispose();
    passwordCtrl.dispose();
    confirrmPassCtrl.dispose();
    super.dispose();
  }

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
                  ? _PersonalInfoRegisterWeb(
                      keyForm: keyForm,
                      passwordCtrl: passwordCtrl,
                      isBuy: widget.isBuy,
                    )
                  : _PersonalInfoRegisterMobile(
                      keyForm: keyForm,
                      nickNameCtrl: nickNameCtrl,
                      firstNameCtrl: firstNameCtrl,
                      firstLastNameCtrl: firstLastNameCtrl,
                      secondNameCtrl: secondNameCtrl,
                      secondLastNameCtrl: secondLastNameCtrl,
                      phoneCtrl: phoneCtrl,
                      emailCtrl: emailCtrl,
                      dateBirthCtrl: dateBirthCtrl,
                      passwordCtrl: passwordCtrl,
                      confirrmPassCtrl: confirrmPassCtrl,
                    ),
            )
          ],
        );
      },
    );
  }
}

//return LayoutBuilder(
//           builder: (_, BoxConstraints constraints) {
//             final double maxWidth = constraints.maxWidth;
//
//             return maxWidth > 1024
//                 ? _PersonalInfoRegisterWeb(
//                     keyForm: keyForm,
//                     passwordCtrl: passwordCtrl,
//                     isBuy: widget.isBuy,
//                   )
//                 : _PersonalInfoRegisterMobile(
//                     keyForm: keyForm,
//                     nickNameCtrl: nickNameCtrl,
//                     firstNameCtrl: firstNameCtrl,
//                     firstLastNameCtrl: firstLastNameCtrl,
//                     secondNameCtrl: secondNameCtrl,
//                     secondLastNameCtrl: secondLastNameCtrl,
//                     phoneCtrl: phoneCtrl,
//                     emailCtrl: emailCtrl,
//                     dateBirthCtrl: dateBirthCtrl,
//                     passwordCtrl: passwordCtrl,
//                     confirrmPassCtrl: confirrmPassCtrl,
//                   );
//           },
