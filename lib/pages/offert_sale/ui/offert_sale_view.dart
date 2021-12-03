import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/offert_sale/offert_sale_view_model.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_app_bar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:provider/provider.dart';

part 'components/card_login.dart';

part 'components/orange_table_summary.dart';

part 'offert_sale_mobile.dart';

part 'offert_sale_web.dart';

class OffertSaleView extends StatelessWidget {
  const OffertSaleView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<OffertSaleViewModel>(
      create: (_) => OffertSaleViewModel(),
      builder: (BuildContext context, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: LdColors.blackBackground,

            title: Text(
              'Crear Oferta',
              style: textTheme.textSmallWhite.copyWith(color: LdColors.white),
            ),
            elevation: 0, // 2
          ),
          backgroundColor: LdColors.blackBackground,
          body: _OffertSaleBody(isBuy: isBuy),
        );
      },
    );
  }
}

class _OffertSaleBody extends StatefulWidget {
  const _OffertSaleBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _OffertSaleBodyState createState() => _OffertSaleBodyState();
}

class _OffertSaleBodyState extends State<_OffertSaleBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController usuarioCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    usuarioCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<OffertSaleViewModel>().onInit(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OffertSaleViewModel viewModel = context.watch<OffertSaleViewModel>();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return maxWidth > 1024
            ? _OffertSaleWeb(
                keyForm: keyForm,
                passwordCtrl: passwordCtrl,
                isBuy: widget.isBuy,
              )
            : _OffertSaleMobile(
                keyForm: keyForm,
                passwordCtrl: passwordCtrl,
                userCtrl: usuarioCtrl,
              );
      },
    );
  }
}
