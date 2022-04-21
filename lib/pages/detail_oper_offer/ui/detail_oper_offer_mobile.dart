part of 'detail_oper_offer_view.dart';

class _DetailOperOfferMobile extends StatelessWidget {
  const _DetailOperOfferMobile({
    Key? key,
    required this.item,
    required this.isBuy,
  }) : super(key: key);

  final dynamic item;
  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DetailOperOfferViewModel viewModel =
        context.watch<DetailOperOfferViewModel>();
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 100;
    final String estado = 'Pagado';
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus || !currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: LdColors.blackBackground,
        appBar: const LdAppbar(
          title: 'Detalles de la oferta',
        ),
        body: Column(
          children: <Widget>[
            const AppbarCircles(hAppbar: hAppbar),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: size.height - hAppbar),
                  decoration: const BoxDecoration(
                    color: LdColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            OperationHeader(
                              isBuy: isBuy,
                              ad: 'efwewer3-r32f3-234ß',
                              textTheme: textTheme,
                              size: size,
                              state: estado,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CardDetailOperOffer(
                              textTheme: textTheme,
                              isBuy: true,
                              state: estado,
                              item: item,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'Comprobante de pago',
                              style: textTheme.subtitleBlack
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CardDetailPay(
                              textTheme: textTheme,
                              viewModel: viewModel,
                              state: estado,
                              isBuy: true,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Información de la oferta',
                              style: textTheme.subtitleBlack
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            CardDetailinfo(
                              textTheme: textTheme,
                              isBuy: true,
                            ),
                            const SizedBox(
                              height: 21,
                            ),
                            Text(
                              'Información adicional',
                              style: textTheme.textGray.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            CardAddInfo(
                              textTheme: textTheme,
                              addInfo:
                                  'Puedo hacer transferencia o consignación nacional a Bancolombia.',
                            ),
                            // const SizedBox(
                            //   height: 40,
                            // ),
                            // CardBankSell(textTheme: textTheme, item: item),
                            const SizedBox(
                              height: 40,
                            ),
                            CardBankBuy(
                              textTheme: textTheme,
                              isBuy: true,
                              state: estado,
                              item: item,
                            ),
                            const SizedBox(
                              height: 56,
                            ),
                            if (estado == 'Pendiente de pago')
                              Container(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: PrimaryButtonCustom(
                                  'Cancelar la compra',
                                  colorText: LdColors.orangePrimary,
                                  colorButton: LdColors.white,
                                  colorTextBorder: LdColors.orangePrimary,
                                  onPressed: () {
                                    _getDialog(context, viewModel);
                                  },
                                ),
                              )
                            else
                              Container(),
                            CardSupport(
                              textTheme: textTheme,
                            ),
                            const SizedBox(
                              height: 53,
                            ),
                            SvgPicture.asset(
                              LdAssets.homeIndicator,
                              height: 5,
                              width: 134,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        )
                      ],
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

  void _getDialog(BuildContext context, DetailOperOfferViewModel viewModel) {
    return LdDialog.buildDenseAlertDialog(
      context,
      image: LdAssets.cancelBuy,
      title: '¿Ya no quieres comprar estos DLYCOP?',
      message:
          'Piénsalo un poco más. El sistema te dará una mala calificación y perderás la oportunidad de tener más DLYCOP.',
      btnText: 'Cancelar la compra',
      onTap: () {},
      btnTextSecondary: 'Cancelar',
      onTapSecondary: () => viewModel.closeDialog(context),
    );
  }
}
