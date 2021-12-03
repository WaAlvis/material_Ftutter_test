// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:localdaily/app_theme.dart';
// import 'package:localdaily/commons/ld_assets.dart';
// import 'package:localdaily/commons/ld_colors.dart';
// import 'package:localdaily/configure/get_it_locator.dart';
// import 'package:localdaily/configure/ld_router.dart';
// import 'package:localdaily/pages/home/home_view_model.dart';
// import 'package:localdaily/pages/home/ui/components/orange_table_summary.dart';
// import 'package:localdaily/services/api_interactor.dart';
// import 'package:localdaily/widgets/input_text_custom.dart';
// import 'package:localdaily/widgets/ld_app_bar.dart';
// import 'package:localdaily/widgets/ld_footer.dart';
// import 'package:localdaily/widgets/primary_button.dart';
// import 'package:provider/provider.dart';
//
// part 'components/card_login.dart';
//
// part '../../home/ui/components/pages_tab_mobil/create_offert/offert_sale_mobile.dart';
//
// part 'offert_sale_web.dart';
//
// class OffertSaleView extends StatelessWidget {
//   const OffertSaleView({Key? key, this.isBuy = false}) : super(key: key);
//
//   final bool isBuy;
//
//   @override
//   Widget build(BuildContext context) {
//     final TextTheme textTheme = Theme.of(context).textTheme;
//
//     return ChangeNotifierProvider<HomeViewModel>(
//       create: (_) => HomeViewModel(
//         locator<LdRouter>(),
//         locator<ServiceInteractor>(),
//       ),
//       builder: (BuildContext context, _) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: LdColors.blackBackground,
//
//             title: Text(
//               'Crear Oferta',
//               style: textTheme.textSmallWhite.copyWith(color: LdColors.white),
//             ),
//             elevation: 0, // 2
//           ),
//           backgroundColor: LdColors.blackBackground,
//           body: _OffertSaleBody(isBuy: isBuy),
//         );
//       },
//     );
//   }
// }
//
// class _OffertSaleBody extends StatefulWidget {
//   const _OffertSaleBody({Key? key, required this.isBuy}) : super(key: key);
//
//   final bool isBuy;
//
//   @override
//   _OffertSaleBodyState createState() => _OffertSaleBodyState();
// }
//
// class _OffertSaleBodyState extends State<_OffertSaleBody> {
//   final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
//   final TextEditingController passwordCtrl = TextEditingController();
//   final TextEditingController usuarioCtrl = TextEditingController();
//
//   @override
//   void dispose() {
//     passwordCtrl.dispose();
//     usuarioCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeViewModel viewModel = context.watch<HomeViewModel>();
//
//     return LayoutBuilder(
//       builder: (_, BoxConstraints constraints) {
//         final double maxWidth = constraints.maxWidth;
//
//         return maxWidth > 1024
//             ? _OffertSaleWeb(
//                 keyForm: keyForm,
//                 passwordCtrl: passwordCtrl,
//                 isBuy: widget.isBuy,
//               )
//             : _OffertSaleMobile(
//                 keyForm: keyForm,
//                 passwordCtrl: passwordCtrl,
//                 userCtrl: usuarioCtrl,
//               );
//       },
//     );
//   }
// }
