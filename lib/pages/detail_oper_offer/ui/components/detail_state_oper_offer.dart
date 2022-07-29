part of '../detail_oper_offer_view.dart';

class DetailState extends StatefulWidget {
  const DetailState({
    Key? key,
    required this.state,
    required this.isBuy,
    required this.item,
    required this.isOper,
    required this.stateDis,
  }) : super(key: key);

  final String state;
  final bool isBuy;
  final ResultDataAdvertisement item;
  final bool isOper;
  final String stateDis;

  @override
  State<DetailState> createState() => _DetailStateState();
}

class _DetailStateState extends State<DetailState> {
  Color _color = LdColors.orangePrimary;
  String stateString = '';
  final DateFormat f = DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    _getColor();
    super.initState();
  }

  void _getColor() {
    switch (widget.state) {
      case 'Cerrado':
        _color = LdColors.blueState;
        stateString =
            'Se cerró la oferta de ${widget.isBuy ? 'compra' : 'venta'} exitosamente.';
        break;
      case 'Pagado':
        _color = widget.stateDis == '4' ? LdColors.redError : LdColors.green;
        stateString = widget.isOper
            ? widget.isBuy
                ? 'Realizaste el pago y adjuntaste el comprobante.'
                : 'El usuario comprador realizó el pago y adjuntó el comprobante de pago.'
            : widget.isBuy
                ? 'Realizaste el pago y adjuntaste el comprobante.'
                : 'El usuario  realizó el pago y adjuntó el comprobante de pago.';
        break;
      case 'Pendiente de pago':
        _color = LdColors.gray;
        stateString = widget.isOper
            ? widget.isBuy
                ? 'Confirmaste la compra. Realiza el pago y adjunta el comprobante.'
                : 'Confirmaste la venta. En espera de recibir el comprobante de pago para la confirmarción.'
            : widget.isBuy
                ? 'El usuario vendedor aceptó vender sus Dailys y te envió la información de pago.'
                : 'El usuario  aceptó comprar tu oferta de venta pero no ha adjuntado el comprobante de pago.';
        break;
      case 'Publicado':
        _color = LdColors.orangePrimary;
        stateString =
            'Se publicó una oferta de ${widget.isBuy ? 'Compra' : 'Venta'}.';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 32, left: 9, right: 87),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: const BorderRadius.all(Radius.circular(17)),
                ),
                child: const Icon(
                  Icons.check,
                  color: LdColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(
                //remplazar por linea discontinua
                width: 8,
              ),
              DottedLine(
                lineThickness: 3,
                dashColor: _color,
                lineLength: 35,
                dashLength: 0.5,
              ),
              const SizedBox(
                //remplazar por linea discontinua
                width: 8,
              ),
              Container(
                height: 24,
                width: 130,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.stateDis == '4' ? 'En disputa' : widget.state,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: LdColors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.only(left: 90, right: 27),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                stateString,
                style: textTheme.textBlack.copyWith(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                // '17/11/2021 - 09:30 a.m',
                f.format(
                  DateTime.fromMillisecondsSinceEpoch(
                    widget.state == 'Publicado'
                        ? widget.item.creationDate
                        : widget.item.modificationDate,
                  ),
                ),
                style: textTheme.textGray.copyWith(fontSize: 14),
              )
            ],
          ),
        )
      ],
    );
  }
}
