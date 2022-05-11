import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/contact_support/contact_support_effect.dart';
import 'package:localdaily/pages/contact_support/contact_support_view_model.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:provider/provider.dart';

part 'contact_support_mobile.dart';

class ContactSupportView extends StatelessWidget {
  const ContactSupportView({
    Key? key,
    required this.advertisementId,
    required this.reference,
    this.isbuy = false,
  }) : super(key: key);
  final String advertisementId;
  final int reference;
  final bool isbuy;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactSupportViewModel>(
      create: (_) => ContactSupportViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        advertisementId,
        reference,
        isbuy: isbuy,
      ),
      child: const ContactSupportBody(),
    );
  }
}

class ContactSupportBody extends StatefulWidget {
  const ContactSupportBody({Key? key}) : super(key: key);

  @override
  State<ContactSupportBody> createState() => _ContactSupportBodyState();
}

class _ContactSupportBodyState extends State<ContactSupportBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late StreamSubscription<ContactSupportEffect> _effectSubscription;
  final TextEditingController _descriptionCtrl = TextEditingController();

  @override
  void initState() {
    final ContactSupportViewModel viewModel =
        context.read<ContactSupportViewModel>();
    final DataUserProvider userProvider = context.read<DataUserProvider>();
    final ConfigurationProvider configurationProvider =
        context.read<ConfigurationProvider>();

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is ShowSnackbarConnectivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ShowSnackbarErrorEffect) {
        LdSnackbar.buildErrorSnackbar(context, event.message);
      } else if (event is ShowSnackbarSuccesEffect) {
        LdSnackbar.buildSuccessSnackbar(
          context,
          'Se envió tu caso a soporte, espera una pronta respuesta en tu email',
        );
      } else if (event is ShowLoadingEffect) {
        LdDialog.buildLoadingDialog(context);
      } else if (event is CreateContactSupportEffect) {
        if (keyForm.currentState!.validate()) {
          viewModel.createContactSupport(
            userProvider.getDataUserLogged!.email,
            userProvider.getDataUserLogged!.id,
            context,
            configurationProvider.getResultSupportType,
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _effectSubscription.cancel();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) => CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: _ContactSupportMobile(
              descriptionCtrl: _descriptionCtrl,
              keyForm: keyForm,
            ),
          )
        ],
      ),
    );
  }
}
