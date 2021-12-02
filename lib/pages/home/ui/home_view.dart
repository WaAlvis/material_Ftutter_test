import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/pages_home_mobile/main_offerts_home.dart';
import 'package:localdaily/pages/home/ui/pages_home_mobile/my_offerts_home.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/data.dart';
import 'package:localdaily/widgets/ld_app_bar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:provider/provider.dart';

// Components Mobile
part 'components/card_buy_and_sell.dart';

// Components web
part 'components_web/information_home.dart';

part 'components_web/product_home.dart';

part 'components_web/security_home.dart';

part 'components_web/start_home.dart';

part 'components_web/table_home.dart';

part 'home_mobile.dart';

part 'home_web.dart';

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
        return const SafeArea(
          child: Scaffold(
            backgroundColor: LdColors.white,
            body: _HomeBody(),
          ),
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
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<HomeViewModel>().onInit(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: maxWidth > 1024
                  ? _HomeWeb(
                      keyForm: keyForm,
                      passwordCtrl: passwordCtrl,
                    )
                  : _HomeMobile(),
            )
          ],
        );
      },
    );
  }
}
