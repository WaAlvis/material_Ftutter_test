import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/offert_buy/offert_buy_view_model.dart';
import 'package:localdaily/providers/user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/widgets/formatters_input_custom.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'components/orange_table_buy.dart';

part 'offert_buy_mobile.dart';

part 'offert_buy_web.dart';

class OffertBuyView extends StatelessWidget {
  const OffertBuyView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<OffertBuyViewModel>(
      create: (_) => OffertBuyViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return _OffertBuyBody(isBuy: isBuy);
      },
    );
  }
}

class _OffertBuyBody extends StatefulWidget {
  const _OffertBuyBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _OffertBuyBodyState createState() => _OffertBuyBodyState();
}

class _OffertBuyBodyState extends State<_OffertBuyBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController marginCtrl = TextEditingController();
  final TextEditingController amountDLYCtrl = TextEditingController();
  final TextEditingController infoPlusOffertCtrl = TextEditingController();

  late FocusNode focusDLYCOP;

  //final TextEditingController usuarioCtrl = TextEditingController();

  @override
  void dispose() {
    marginCtrl.dispose();
    amountDLYCtrl.dispose();
    infoPlusOffertCtrl.dispose();
    focusDLYCOP.dispose();
    super.dispose();
  }

  @override
  void initState() {
    focusDLYCOP = FocusNode();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<OffertBuyViewModel>().onInit(context);
    });
    marginCtrl.addListener(_printLatestValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OffertBuyViewModel viewModel = context.watch<OffertBuyViewModel>();
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
                      ? _OffertBuyWeb(
                          keyForm: keyForm,
                          valueDLYCOP: marginCtrl,
                          isBuy: widget.isBuy,
                        )
                      : _OffertBuyMobile(
                          keyForm: keyForm,
                          focusDLYCOP: focusDLYCOP,
                          marginCtrl: marginCtrl,
                          infoPlusOffertCtrl: infoPlusOffertCtrl,
                          amountDLYCtrl: amountDLYCtrl,
                        ),
                ),
              ],
            ),
            loading,
          ],
        );
      },
    );
  }

  void _printLatestValue() {
    print('Second text field: ${marginCtrl.text}');
  }
}
