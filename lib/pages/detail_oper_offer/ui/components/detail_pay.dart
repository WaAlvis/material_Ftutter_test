part of '../detail_oper_offer_view.dart';

class CardDetailPay extends StatelessWidget {
  const CardDetailPay({
    Key? key,
    required this.textTheme,
    required this.isBuy,
    required this.state,
    required this.viewModel,
    required this.isOper,
    required this.item,
  }) : super(key: key);
  final TextTheme textTheme;
  final bool isBuy;
  final String state;
  final DetailOperOfferViewModel viewModel;
  final bool isOper;
  final ResultDataAdvertisement item;

  @override
  Widget build(BuildContext context) {
    Color _color = LdColors.orangePrimary;
    String _comprobante = LdAssets.comprobante3;
    String _title1 = '';
    String _title2 = '';
    switch (state) {
      case 'Cerrado':
        _color = LdColors.blueState;
        _comprobante = LdAssets.comprobante3;
        _title1 = isBuy
            ? 'Adjuntaste el comprobante de pago.'
            : 'Comprador adjuntó un comprobante de pago.';
        _title2 = '';
        break;
      case 'Pagado':
        _color = LdColors.green;
        _comprobante = LdAssets.comprobante;
        _title1 = isBuy
            ? 'Adjuntaste el comprobante de pago.'
            : 'Comprador adjuntó un comprobante de pago.';
        _title2 =
            isBuy ? '' : 'Valida la información antes de confirmar el pago.';
        break;
      case 'Pendiente de pago':
        _color = LdColors.gray;
        _comprobante = LdAssets.comprobante2;
        _title1 = isBuy
            ? 'No has adjuntado el comprobante de pago.'
            : 'El comprador no ha adjuntado el comprobante de pago.';
        break;
      case 'Publicado':
        _color = LdColors.orangePrimary;
        _comprobante = LdAssets.comprobante4;
        _title1 = isBuy
            ? 'Aún no tienes un vendedor interesado'
            : 'Aún no tienes comprobantes de pago.';

        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: _color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.asset(
                  _comprobante,
                  height: 104,
                  width: 104,
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        _title1,
                        style: textTheme.textBlack.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: state == 'Publicado'
                                ? LdColors.orangePrimary
                                : LdColors.black),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        _title2,
                        style: textTheme.textGray.copyWith(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (state == 'Publicado')
                        Container()
                      else
                        GestureDetector(
                          onTap: () {}, //Abrir perfil del comprador
                          child: Text(
                            isBuy ? 'Ver el vendedor' : 'Ver el comprador',
                            style: textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              color: LdColors.orangePrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            if (state == 'Pendiente de pago' || state == 'Publicado')
              Container()
            else
              PrimaryButtonCustom(
                'Ver comprobante (1)',
                colorText: _color,
                colorButton: LdColors.white,
                colorTextBorder: _color,
                onPressed: () {
                  viewModel.goAttachedFile(context, viewModel.isOper, '1');
                },
              ),
            const SizedBox(
              height: 10,
            ),
            if (state == 'Pagado' || state == 'Pendiente de pago')
              if (isBuy && state == 'Pendiente de pago')
                PrimaryButtonCustom(
                  isBuy ? 'Adjuntar' : 'Confirmar pago',
                  colorButton:
                      state == 'Pendiente de pago' ? LdColors.white : _color,
                  colorTextBorder:
                      state == 'Pendiente de pago' ? _color : LdColors.white,
                  icon: isBuy ? Icons.attach_file : null,
                  colorText: LdColors.white,
                  onPressed: isBuy
                      ? () {
                          viewModel.goAttachedFile(
                              context, viewModel.isOper, '');
                        }
                      : () {}, //confirmar pago,
                )
              else if (state == 'Pagado' && !isBuy)
                PrimaryButtonCustom(
                  isBuy ? 'Adjuntar' : 'Confirmar pago',
                  colorButton:
                      state == 'Pendiente de pago' ? LdColors.white : _color,
                  colorTextBorder:
                      state == 'Pendiente de pago' ? _color : LdColors.white,
                  icon: isBuy ? Icons.attach_file : null,
                  colorText: LdColors.white,
                  onPressed: () {
                    viewModel.getDialogConfirmPay(context, viewModel);
                  },
                )
              else if (state == 'Pagado' && isBuy)
                PrimaryButtonCustom(
                  isBuy ? 'Adjuntar' : 'Confirmar pago',
                  colorButton:
                      state == 'Pendiente de pago' ? LdColors.white : _color,
                  colorTextBorder:
                      state == 'Pendiente de pago' ? _color : LdColors.white,
                  icon: isBuy ? Icons.attach_file : null,
                  colorText: LdColors.white,
                  onPressed: isBuy
                      ? () {
                          viewModel.goAttachedFile(
                              context, viewModel.isOper, '');
                        }
                      : () {
                          viewModel.getDialogConfirmPay(context, viewModel);
                        },
                )
              else
                Container()
            else
              Container()
          ],
        ),
      ),
    );
  }
}
