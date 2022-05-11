import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/ui/components/advice_message.dart';
import 'package:localdaily/pages/notification/notification_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/notifications/notification.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'notification_mobile.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationViewModel>(
      create: (_) => NotificationViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      child: const _NotificationBody(),
    );
  }
}

class _NotificationBody extends StatefulWidget {
  const _NotificationBody({Key? key}) : super(key: key);

  @override
  _NotificationBodyState createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<_NotificationBody> {
  final ScrollController _notiScrollCtrl = ScrollController();

  @override
  void initState() {
    final NotificationViewModel viewModel =
        context.read<NotificationViewModel>();
    final DataUserProvider userProvider = context.read<DataUserProvider>();

    _notiScrollCtrl.addListener(() {
      if (_notiScrollCtrl.position.pixels >
              _notiScrollCtrl.position.maxScrollExtent &&
          !viewModel.status.isLoading) {
        if (_notiScrollCtrl.position.maxScrollExtent != 0 &&
            viewModel.status.resultNotification.data.length !=
                viewModel.status.resultNotification.totalItems) {
          _notiScrollCtrl.jumpTo(
            _notiScrollCtrl.position.maxScrollExtent,
          );
        }

        viewModel
            .getData(
          userProvider.getDataUserLogged?.id ?? '',
          isPagination: true,
        )
            .then(
          (bool? value) {
            if (_notiScrollCtrl.position.maxScrollExtent != 0 &&
                value == null) {
              _notiScrollCtrl.animateTo(
                _notiScrollCtrl.position.maxScrollExtent + 150,
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
              );
            }
          },
        );
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      viewModel.onInit(userProvider.getDataUserLogged?.id ?? '');
    });

    super.initState();
  }

  @override
  void dispose() {
    _notiScrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: _NotificationMobile(notiScrollCtrl: _notiScrollCtrl),
            )
          ],
        );
      },
    );
  }
}
