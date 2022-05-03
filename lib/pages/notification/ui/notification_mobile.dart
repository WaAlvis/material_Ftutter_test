part of 'notification_view.dart';

class _NotificationMobile extends StatelessWidget {
  const _NotificationMobile({Key? key, required this.notiScrollCtrl})
      : super(key: key);
  final ScrollController notiScrollCtrl;

  @override
  Widget build(BuildContext context) {
    const double hAppbar = 100;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                    await Future.delayed(Duration(seconds: 1));
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    controller: notiScrollCtrl,
                    itemBuilder: (BuildContext context, int index) {
                      return _NotificationSlide(
                        index: index,
                        notificationType: NotificationType.c,
                        offerStatus: OfferStatus.Pendiente,
                      );
                    },
                  ),
                ),
                //_EmptyNotifications(),
              ),
            ),
          )
        ],
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
    required this.index,
    required this.notificationType,
    required this.offerStatus,
  }) : super(key: key);
  final int index;
  final NotificationType notificationType;
  final OfferStatus offerStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: ValueKey<int>(index),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // TODO: Eliminar la notificación de la lista local y posteriormente de la bd? inhabilitar
          dismissible: DismissiblePane(onDismissed: () {}),
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
          offerStatus: offerStatus,
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    Key? key,
    required this.notificationType,
    required this.offerStatus,
  }) : super(key: key);
  final NotificationType notificationType;
  final OfferStatus offerStatus;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color colorLight = _getNotificationColor(
      notificationType,
      offerStatus,
      isLight: true,
    );
    final Color color = _getNotificationColor(notificationType, offerStatus);
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
                  'Ejemplo de notificación',
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
                        const TextSpan(
                            text:
                                'Tu oferta de venta #00001 pasó al estado cerrado. Los DLYCOP fueron entregados. '),
                        TextSpan(
                          text: '17/11/2021 - 08:34 a.m.',
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
  NotificationType notificationType,
  OfferStatus offerStatus, {
  bool isLight = false,
}) {
  if (notificationType == NotificationType.sc ||
      notificationType == NotificationType.sv) {
    return isLight ? LdColors.yellowlight : LdColors.yellowDark;
  } else if (notificationType == NotificationType.t) {
    return isLight ? LdColors.redlight : LdColors.orangeWarning;
  } else if (offerStatus == OfferStatus.Publicado) {
    return isLight ? LdColors.orangelight : LdColors.orangePrimary;
  } else if (offerStatus == OfferStatus.Pendiente) {
    return isLight ? LdColors.graylight : LdColors.blackText;
  } else if (offerStatus == OfferStatus.Cerrado) {
    return isLight ? LdColors.bluelight : LdColors.blueDark;
  } else {
    return isLight ? LdColors.greenlight : LdColors.green;
  }
}
