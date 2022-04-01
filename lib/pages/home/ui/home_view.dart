import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/history/history_view_model.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/components/advice_message.dart';
import 'package:localdaily/pages/home/ui/components/pages_tab_mobil/create_offer/list_my_offer_sale.dart';
import 'package:localdaily/pages/home/ui/components/pages_tab_mobil/main_offers/list_offers_main_cards.dart';
import 'package:localdaily/pages/home/ui/components/pages_tab_mobil/operation_offer/list_operations_offers.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/view_model.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';

part 'components/pages_tab_mobil/create_offer/my_offers_tab.dart';
part 'components/pages_tab_mobil/profile_user/profile_user_tab.dart';

// Components Mobile
part 'components/pages_tab_mobil/main_offers/card_wallet_connect.dart';

part 'components/pages_tab_mobil/main_offers/card_buy_and_sell.dart';

part 'components/pages_tab_mobil/main_offers/main_offers_tab.dart';

part 'components/pages_tab_mobil/operation_offer/operation_card.dart';

part 'components/pages_tab_mobil/operation_offer/operations_offers_tab.dart';

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
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context
          .read<HomeViewModel>()
          .onInit(context, dataUserProvider.getDataUserLogged?.id ?? '');
    });
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
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: maxWidth > 1024
                      ? _HomeWeb(
                          keyForm: keyForm,
                          passwordCtrl: passwordCtrl,
                        )
                      : const _HomeMobile(),
                )
              ],
            ),
            //loading,
          ],
        );
      },
    );
  }
}
