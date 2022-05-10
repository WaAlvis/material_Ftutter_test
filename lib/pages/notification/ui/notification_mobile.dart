part of 'notification_view.dart';

class _NotificationMobile extends StatelessWidget {
  const _NotificationMobile({
    Key? key,
    required this.notiScrollCtrl,
  }) : super(key: key);
  final ScrollController notiScrollCtrl;

  @override
  Widget build(BuildContext context) {
    const double hAppbar = 100;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    final NotificationViewModel viewModel =
        context.watch<NotificationViewModel>();
    final DataUserProvider userProvider = context.read<DataUserProvider>();
    final List<NotificationP> items = viewModel.status.resultNotification.data;

    return WillPopScope(
      onWillPop: () => viewModel.goHome(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: LdColors.blackBackground,
        appBar: const LdAppbar(title: 'Notificaciones'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AppbarCircles(hAppbar: hAppbar),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: size.height - hAppbar,
                  constraints: BoxConstraints(
                    minHeight: size.height - hAppbar,
                    maxHeight: size.height - hAppbar,
                  ),
                  padding: const EdgeInsets.all(18.0),
                  decoration: const BoxDecoration(
                    color: LdColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: RefreshIndicator(
                    color: LdColors.orangePrimary,
                    onRefresh: () async {
                      await viewModel.getData(
                        userProvider.getDataUserLogged?.id ?? '',
                        refresh: true,
                      );
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      shrinkWrap: items.isEmpty,
                      itemCount: viewModel.status.isLoading
                          ? 10
                          : items.isEmpty
                              ? 1
                              : items.length,
                      controller: notiScrollCtrl,
                      itemBuilder: (BuildContext context, int index) {
                        return viewModel.status.isLoading
                            ? Shimmer.fromColors(
                                baseColor: LdColors.whiteDark,
                                highlightColor: LdColors.grayButton,
                                child: const Card(
                                  margin: EdgeInsets.all(10),
                                  child: SizedBox(height: 100),
                                ),
                              )
                            : items.isEmpty
                                ? IntrinsicHeight(child: _EmptyNotifications())
                                : _NotificationSlide(
                                    viewModel: viewModel,
                                    notificationType:
                                        NotificationType.values.firstWhere(
                                      (element) =>
                                          element.name ==
                                          items[index]
                                              .identifierCode
                                              .toLowerCase(),
                                    ),
                                    notification: items[index],
                                  );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: AdviceMessage(
            imageName: LdAssets.emptyNotification,
            title: 'Aún no tienes notificaciones',
            description:
                'Vuelve a revisar cuando abras operaciones o crees ofertas.',
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}

class _NotificationSlide extends StatelessWidget {
  const _NotificationSlide({
    Key? key,
    required this.notificationType,
    required this.notification,
    required this.viewModel,
  }) : super(key: key);
  final NotificationType notificationType;
  final NotificationP notification;
  final NotificationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () => viewModel.removeNotification(notification.id),
          ),
          children: const <Widget>[
            SlidableAction(
              onPressed: null,
              backgroundColor: LdColors.redError,
              foregroundColor: LdColors.white,
              icon: Icons.delete,
              label: 'Eliminar',
            ),
          ],
        ),
        child: _NotificationCard(
          notificationType: notificationType,
          notification: notification,
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    Key? key,
    required this.notificationType,
    required this.notification,
  }) : super(key: key);
  final NotificationType notificationType;
  final NotificationP notification;

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('dd-MM-yyyy hh:mm a');
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color colorLight = _getNotificationColor(
      notification,
      isLight: true,
    );
    final Color color = _getNotificationColor(notification);
    final bool needContrast = notificationType == NotificationType.sc ||
        notificationType == NotificationType.sv;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  notificationType.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: textTheme.textBigBlack.copyWith(
                    fontWeight: FontWeight.w700,
                    color: needContrast ? LdColors.blackText : colorLight,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  notification.tittle,
                  style: textTheme.textBlack.copyWith(
                    fontWeight: FontWeight.w500,
                    color: needContrast ? LdColors.blackText : color,
                  ),
                ),
                const SizedBox(height: 3),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.textBlack.copyWith(
                        fontSize: 14,
                        color: LdColors.blackText,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '${notification.message} '),
                        TextSpan(
                          text: format.format(
                            DateTime.fromMillisecondsSinceEpoch(
                              notification.createDate,
                            ),
                          ),
                          style: textTheme.textBlack
                              .copyWith(fontSize: 12, color: LdColors.gray),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Color _getNotificationColor(
  NotificationP notification, {
  bool isLight = false,
}) {
  if (notification.isSupportNotification) {
    return isLight ? LdColors.yellowlight : LdColors.yellowDark;
  } else if (notification.isExpirationDate) {
    return isLight ? LdColors.redlight : LdColors.orangeWarning;
  } else if (notification.isPublishNotification) {
    return isLight ? LdColors.orangelight : LdColors.orangePrimary;
  } else if (notification.isPendingNotification) {
    return isLight ? LdColors.graylight : LdColors.blackText;
  } else if (notification.isClosingNotification) {
    return isLight ? LdColors.bluelight : LdColors.blueDark;
  } else {
    return isLight ? LdColors.greenlight : LdColors.green;
  }
}
