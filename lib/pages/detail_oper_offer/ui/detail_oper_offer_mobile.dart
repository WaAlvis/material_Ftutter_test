part of 'detail_oper_offer_view.dart';

class _DetailOperOfferMobile extends StatelessWidget {
  const _DetailOperOfferMobile({
    Key? key,
    required this.isBuy,
  }) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DetailOperOfferViewModel viewModel =
        context.watch<DetailOperOfferViewModel>();
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 100;
    final String estado =
        viewModel.status.state == null ? 'Publicado' : viewModel.status.state!;
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
                              expiredDate: viewModel.status.dateOfExpire,
                              isBuy: viewModel.status.isBuy,
                              ad: viewModel.status.item?.reference.toString() ??
                                  '',
                              textTheme: textTheme,
                              size: size,
                              state: estado,
                              isOper: viewModel.status.isOper2,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (viewModel.status.item != null)
                              CardDetailOperOffer(
                                textTheme: textTheme,
                                isBuy: viewModel.status.isBuy,
                                state: estado,
                                item: viewModel.status.item!,
                                viewModel: viewModel,
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
                            if (viewModel.status.item != null)
                              CardDetailPay(
                                textTheme: textTheme,
                                viewModel: viewModel,
                                state: estado,
                                isBuy: viewModel.status.isBuy,
                                isOper: viewModel.status.isOper2,
                                item: viewModel.status.item!,
                              )
                            else
                              Container(),
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
                            if (viewModel.status.item != null)
                              CardDetailinfo(
                                textTheme: textTheme,
                                isBuy: viewModel.status.isBuy,
                                item: viewModel.status.item!,
                              )
                            else
                              Container(),
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

                            if (viewModel.status.item != null)
                              CardAddInfo(
                                textTheme: textTheme,
                                addInfo: viewModel.status.item!.termsOfTrade,
                              )
                            else
                              CardAddInfo(
                                textTheme: textTheme,
                                addInfo: '',
                              ),
                            // const SizedBox(
                            //   height: 40,
                            // ),
                            // CardBankSell(textTheme: textTheme, item: item),
                            const SizedBox(
                              height: 40,
                            ),
                            if (viewModel.status.item != null)
                              CardBankBuy(
                                textTheme: textTheme,
                                isBuy: viewModel.status.isBuy,
                                state: estado,
                                viewModel: viewModel,
                              ),
                            const SizedBox(
                              height: 56,
                            ),
                            if (estado == 'Pendiente de pago' &&
                                    viewModel.status.isOper2 ||
                                estado == 'Publicado')
                              Container(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: PrimaryButtonCustom(
                                  isBuy
                                      ? viewModel.status.isOper2
                                          ? 'Cancelar la compra'
                                          : 'Quitar la publicación'
                                      : viewModel.status.isOper2
                                          ? 'Cancelar la venta'
                                          : 'Quitar la publicación',
                                  colorText: LdColors.orangePrimary,
                                  colorButton: LdColors.white,
                                  colorTextBorder: LdColors.orangePrimary,
                                  onPressed: () {
                                    viewModel.getDialog(
                                      context,
                                      viewModel,
                                      isBuy,
                                      viewModel.status.isOper2,
                                    );
                                  },
                                ),
                              )
                            else
                              Container(),
                            if (viewModel.status.item != null)
                              CardSupport(
                                textTheme: textTheme,
                              ),
                            const SizedBox(
                              height: 53,
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
}
