part of 'offer_buy_view.dart';

class _OfferBuyMobile extends StatelessWidget {
  const _OfferBuyMobile({
    Key? key,
    required this.keyForm,
    required this.marginCtrl,
    required this.amountDLYCtrl,
    required this.infoPlusOfferCtrl,
    required this.focusDLYCOP,
    required this.cancelSecretCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final FocusNode focusDLYCOP;
  final TextEditingController marginCtrl;
  final TextEditingController amountDLYCtrl;
  final TextEditingController infoPlusOfferCtrl;
  final TextEditingController cancelSecretCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OfferBuyViewModel viewModel = context.watch<OfferBuyViewModel>();
    final Size size = MediaQuery.of(context).size;
    const double hAppbar = 100;
    final double hBody = size.height - hAppbar;
    NumberFormat f = new NumberFormat("#,##0.00", "es_AR");

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus || !currentFocus.hasFocus) {
          currentFocus.unfocus();
          marginCtrl.text = viewModel.completeEditMargin(
            marginCtrl.text,
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: LdColors.blackBackground,
        appBar: const LdAppbar(
          title: 'Crear oferta',
          // withBackIcon: false,
        ),
        body: Column(children: [
          const AppbarCircles(hAppbar: hAppbar),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Form(
                        key: keyForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Oferta de compra',
                              style: textTheme.subtitleBlack.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Ingresa la informacion de la publicacion.',
                              style: textTheme.textBlack,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            InputTextCustom(
                              'Valor de los DLYCOP*',
                              counterText: 'Min: 0.8, Max: 9.9',
                              onChange: (_) => viewModel.calculateTotalMoney(
                                marginCtrl.text,
                                amountDLYCtrl.text,
                              ),
                              onTap: () => marginCtrl.text =
                                  viewModel.resetValueMargin(marginCtrl.text),
                              onEditingComplete: () => marginCtrl.text =
                                  viewModel.completeEditMargin(
                                marginCtrl.text,
                              ),
                              style: const TextStyle(
                                color: LdColors.orangePrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: marginCtrl,
                              validator: (String? value) =>
                                  viewModel.validatorNotEmpty(value),
                              changeFillWith: !viewModel.status.isMarginEmpty,
                              hintText: '0 COP',
                              hintStyle: TextStyle(
                                color: LdColors.orangePrimary.withOpacity(0.7),
                                fontSize: 18,
                              ),
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter.allow(
                              //     RegExp(r'(^\d*\.?\d*)$'),
                              //     // RegExp('[0-9]+[,.]{0,1}[0-9]*'),
                              //   ),
                              //   // DecimalTextInputFormatter(decimalRange: 1),
                              // ],
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]+[,.]{0,1}[0-9]*'),
                                ),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?\.?\d{0,1}'),
                                ),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              '¿Cuantos DLYCOP vas a comprar?*',
                              style: textTheme.textBlack,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AmountOrangeTableBuy(
                              textTheme: textTheme,
                              validator: (String? value) =>
                                  viewModel.validatorAmount(value),
                              onChange: (_) => viewModel.calculateTotalMoney(
                                marginCtrl.text,
                                amountDLYCtrl.text,
                              ),
                              controller: amountDLYCtrl,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Informacion adicional (opcional)'),
                            const SizedBox(height: 8),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              controller: infoPlusOfferCtrl,
                              minLines: 5,
                              //Normal textInputField will be displayed
                              maxLines: 5,
                              maxLength: 250,
                              // when user presses enter it will adapt to it
                              decoration: const InputDecoration(
                                hintText:
                                    'Ingresa información adicional para los vendedores...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 150,
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                                right: 25,
                                left: 20,
                              ),
                              decoration: const BoxDecoration(
                                color: LdColors.grayBorder,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.access_time_rounded,
                                    size: 60,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'La oferta Expirará en  ',
                                        style: textTheme.textBlack,
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: '7 dias ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                              text:
                                                  'desde el momento de la publicación.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButtonCustom(
                              'Crear oferta de compra',
                              onPressed: viewModel.onClickCreateOffer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
