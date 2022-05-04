import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/contact_support/contact_support_view_model.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
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
  final String reference;
  final bool isbuy;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactSupportViewModel>(
      create: (_) => ContactSupportViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
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
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _mobileCtrl.dispose();
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
              mobileCtrl: _mobileCtrl,
            ),
          )
        ],
      ),
    );
  }
}
