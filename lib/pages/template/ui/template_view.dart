import 'package:flutter/material.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:provider/provider.dart';

part 'template_mobile.dart';
part 'template_web.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
          locator<LdRouter>(),
          locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _HomeBody(),
        );
      },
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;

      return CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: maxWidth > 1024
              ? _TemplateWeb(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                )
              : _TemplateMobile(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                ),
          )
        ],
      );
    },);
  }
}
