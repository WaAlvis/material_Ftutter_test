import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/components/pages_tab_mobil/create_offert/list_my_offer_sale.dart';
import 'package:localdaily/pages/home/ui/components/pages_tab_mobil/main_offerts/list_offerts_main_cards.dart';
import 'package:localdaily/providers/user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/data.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'components/pages_tab_mobil/create_offert/my_offerts_tab.dart';

// Components Mobile
part 'components/pages_tab_mobil/main_offerts/card_buy_and_sell.dart';

part 'components/pages_tab_mobil/main_offerts/main_offerts_tab.dart';

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
        return const _HomeBody();
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

  // late StreamSubscription<RecoverPasswordEffect> _effectSubscription;

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

    // final HomeViewModel viewModel = context.read<HomeViewModel>();
    //
    // _effectSubscription = viewModel.effects.listen((RecoverPasswordEffect event) {
    //   if(event is ShowDialogRecoverPasswordEffect){
    //     DlyDialog.buildSmsDialog(
    //       context,
    //       message: event.message,
    //       title: 'Observación',
    //       onTapSend: ()=> viewModel.goPassword(context),
    //       onTapClose: viewModel.onTapClose,
    //     );
    //   }
    //   else if(event is ShowSnackbarConnectivityEffect){
    //     DlySnackbar.buildConnectivitySnackbar(context, event.message);
    //   }
    //   else if(event is FormValidateRecoverPasswordEffect) {
    //     if(keyForm.currentState!.validate()){
    //       viewModel.showDialogConfirmation(phoneCtrl.text);
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : SizedBox.shrink();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return Stack(
          children: [
            CustomScrollView(
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
            ),
            loading,
          ],
        );
      },
    );
  }
}
