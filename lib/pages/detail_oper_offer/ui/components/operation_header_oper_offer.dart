part of '../detail_oper_offer_view.dart';

class OperationHeader extends StatelessWidget {
  const OperationHeader({
    Key? key,
    required this.isBuy,
    required this.ad,
    required this.textTheme,
    required this.size,
    required this.state,
    required this.expiredDate,
  }) : super(key: key);

  // final TypeOffer type;
  // final Advertisement ad;
  final bool isBuy;
  final String ad;
  final TextTheme textTheme;
  final Size size;
  final String state;
  final int expiredDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          isBuy ? 'Oferta de compra' : 'Detalles de la venta',
          style: textTheme.subtitleBlack.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              // '# referencia: ${ad.id.substring(0, 5)}',
              '# referencia: $ad',
              style: textTheme.textGray,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 6,
              ),
              decoration: BoxDecoration(
                color: state == 'Cerrado'
                    ? LdColors.redError
                    : LdColors.orangePrimary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: state == 'Cerrado'
                  ? Row(
                      children: <Widget>[
                        const Icon(
                          Icons.timer,
                          color: LdColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        // TODO: Calcular tiempo restante de la publicacion
                        Text(
                          'Finalizado',
                          style: textTheme.textWhite,
                        )
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        const Icon(
                          Icons.event,
                          color: LdColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        // TODO: Calcular tiempo restante de la publicacion
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                    expiredDate,
                                    // 1640979000000,
                                  )
                                      .difference(
                                        DateTime.now(),
                                      )
                                      .inDays >
                                  0
                              ? '${DateTime.fromMillisecondsSinceEpoch(
                                  expiredDate,
                                  // 1640979000000,
                                ).difference(
                                    DateTime.now(),
                                  ).inDays.toString()} d'
                              : '0 d',
                          style: textTheme.textWhite,
                        )
                      ],
                    ),
            )
          ],
        ),
      ],
    );
  }
}
