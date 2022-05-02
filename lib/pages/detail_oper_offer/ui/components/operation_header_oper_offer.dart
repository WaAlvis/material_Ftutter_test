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
    required this.isOper,
  }) : super(key: key);

  // final TypeOffer type;
  // final Advertisement ad;
  final bool isBuy;
  final String ad;
  final TextTheme textTheme;
  final Size size;
  final String state;
  final int expiredDate;
  final bool isOper;

  @override
  Widget build(BuildContext context) {
    final DetailOperOfferViewModel viewModel =
        context.watch<DetailOperOfferViewModel>();
    // print('horas para expirar oferta ${viewModel.status.dateHours}');
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          isBuy
              ? viewModel.status.isOper2
                  ? 'Detalle de la compra'
                  : 'Oferta de compra'
              : viewModel.status.isOper2
                  ? 'Detalle de la venta'
                  : 'Oferta de venta',
          style: textTheme.subtitleBlack.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (state != 'Pendiente de pago')
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
                            expiredDate > 0 ? '$expiredDate d' : '0 d',
                            style: textTheme.textWhite,
                          )
                        ],
                      ),
              )
            ],
          )
        else
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.check_box,
                        color: LdColors.orangePrimary,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Oferta de ${isBuy ? 'Compra' : 'venta'} reservada',
                          style: textTheme.bodyText2?.copyWith(
                              color: LdColors.orangePrimary, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        color: LdColors.redError,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.timer,
                            color: LdColors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          // TODO: Calcular tiempo restante de la publicacion
                          if (viewModel.status.dateHours != null)
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                viewModel.status.dateHours! > 72
                                    ? 'Finalizado'
                                    : '${viewModel.status.dateHours} h',
                                style: textTheme.textWhite,
                              ),
                            )
                        ],
                      )),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    // '# referencia: ${ad.id.substring(0, 5)}',
                    '# referencia: $ad',
                    style: textTheme.textGray,
                  ),
                ],
              )
            ],
          )
      ],
    );
  }
}
