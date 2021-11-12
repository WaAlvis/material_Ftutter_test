import 'package:flutter/material.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/personal_info_register/personal_info_register_view_model.dart';
import 'package:localdaily/widgets/ld_app_bar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:provider/provider.dart';

part 'components/card_register.dart';


part 'personal_info_register_mobile.dart';
part 'personal_info_register_web.dart';

class PersonalInfoRegisterView extends StatelessWidget {
  const PersonalInfoRegisterView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersonalInfoRegisterViewModel>(
      create: (_) => PersonalInfoRegisterViewModel(
          locator<LdRouter>(),
          locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return Scaffold(
          backgroundColor: LdColors.white,
          body: _PersonalInfoRegisterBody(isBuy: isBuy),
        );
      },
    );
  }
}

class _PersonalInfoRegisterBody extends StatefulWidget {

  const _PersonalInfoRegisterBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _PersonalInfoRegisterBodyState createState() => _PersonalInfoRegisterBodyState();
}

class _PersonalInfoRegisterBodyState extends State<_PersonalInfoRegisterBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final PersonalInfoRegisterViewModel viewModel = context.watch<PersonalInfoRegisterViewModel>();

    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;

      return CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: maxWidth > 1024
              ? _PersonalInfoRegisterWeb(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                  isBuy: widget.isBuy
                )
              : _PersonalInfoRegisterMobile(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                ),
          )
        ],
      );
    },);
  }
}
