import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/attached_file/attached_file_view_model.dart';
import 'package:localdaily/pages/attached_file/attahced_file_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

import '../attached_file_view_model.dart';

part 'attached_file_web.dart';

part 'attached_file_mobile.dart';

part 'components/operation_header_oper_offer.dart';

part 'components/interactive_attached_file.dart';

class AttachedFileView extends StatelessWidget {
  const AttachedFileView({
    Key? key,
    this.item,
    this.isBuy = false,
  }) : super(key: key);

  final dynamic item;
  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<AttachedFileViewModel>(
      create: (_) => AttachedFileViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        item!,
        isBuy: isBuy,
      ),
      builder: (BuildContext context, _) {
        return _AttachedFileBody(
          isBuy: isBuy,
          item: item!,
        );
      },
    );
  }
}

class _AttachedFileBody extends StatefulWidget {
  const _AttachedFileBody({
    Key? key,
    required this.isBuy,
    required this.item,
  }) : super(key: key);
  final bool isBuy;
  final dynamic item;
  @override
  State<_AttachedFileBody> createState() => __AttachedFileBodyState();
}

class __AttachedFileBodyState extends State<_AttachedFileBody> {
  late StreamSubscription<AttachedFileEffect> _effectSubscription;

  @override
  void initState() {
    final AttachedFileViewModel viewModel =
        context.read<AttachedFileViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<AttachedFileViewModel>().onInit(context);
    });
    _effectSubscription = viewModel.effects.listen((AttachedFileEffect event) {
      if (event is ShowSnackConnetivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ShowSnackbarSuccesEffect) {
        LdSnackbar.buildSuccessSnackbar(
          context,
          'Se envio exitosamente el archivo',
        );
      } else if (event is ShowSnackbarErrorEffect) {
        LdSnackbar.buildErrorSnackbar(context, event.message);
      } else if (event is ShowLoadingEffect) {
        LdDialog.buildLoadingDialog(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AttachedFileViewModel viewModel =
        context.watch<AttachedFileViewModel>();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: maxWidth > 1024
                  ? const _AttachedFileWeb()
                  : _AttachedFileMobile(),
            ),
          ],
        );
      },
    );
  }
}
