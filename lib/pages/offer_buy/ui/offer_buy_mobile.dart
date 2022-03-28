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
                              inputFormatters: <TextInputFormatter>[
                                NumericalRangeFormatter(max: 3, min: 0),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\,?\d{0,2}'),
                                ),
                                // FilteringTextInputFormatter.deny(RegExp(r'[ -]')),
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
                                  viewModel.validatorNotEmpty(value),
                              onChange: (_) => viewModel.calculateTotalMoney(
                                marginCtrl.text,
                                amountDLYCtrl.text,
                              ),
                              controller: amountDLYCtrl,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Entidades para realizar el pago',
                              style: textTheme.textBigBlack,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Esta imformacion solo se mostrar al usuario que comfirme la compra de tus Dailys y servirá para que pueda hacer el pago correspondiente.',
                              style: textTheme.textGray,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DropdownCustom(
                              'Entidad *',
                              hintText: 'Seleciona tu entidad',
                              validator: (String? value) =>
                                  viewModel.validatorNotEmpty(value),
                              changeFillWith:
                                  viewModel.status.selectedBank != null,
                              optionItems: viewModel.status.listBanks.data
                                  .map((Bank item) {
                                return DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(item.description),
                                );
                              }).toList(),
                              onChanged: (String? idBank) =>
                                  viewModel.bankSelected(idBank!),
                              value: viewModel.status.selectedBank?.id,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButtonCustom(
                              'Agregar Entidad',
                              icon: Icons.add_circle_outline_outlined,
                              colorButton: LdColors.white,
                              colorTextBorder: LdColors.orangePrimary,
                              onPressed: () => viewModel,
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
                                    'Ingresa informacion adicional para los compradores...',
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
                            InputTextCustom(
                              'Establece una palabra clave para asegurar tus recursos',
                              hintText: 'Ingresa tu palabra secreta',
                              validator: (String? value) =>
                                  viewModel.validatorNotEmpty(value),
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9a-zA-Z.]'),
                                ),
                              ],
                              controller: cancelSecretCtrl,
                            ),
                            const SizedBox(
                              height: 40,
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
                              'Crear oferta de venta',
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

class DropdownCustom extends StatelessWidget {
  DropdownCustom(
    this.data, {
    Key? key,
    required this.hintText,
    required this.optionItems,
    required this.onChanged,
    required this.value,
    this.changeFillWith,
    this.validator,
    // this.styleLabel,
    // this.styleHint,
    // this.suffixIcon,
  }) : super(key: key);

  final String data;
  final String hintText;
  final List<DropdownMenuItem<String>>? optionItems;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? value;
  bool? changeFillWith = false;

  @override
  Widget build(BuildContext context) {
    final OfferBuyViewModel viewModel = context.watch<OfferBuyViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            data,
            style: textTheme.textBlack,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            filled: changeFillWith,

            // filled: changeFillWith != null ,
            hintText: hintText,
            fillColor: LdColors.grayBorder,
          ),
          validator: validator,
          items: optionItems,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
