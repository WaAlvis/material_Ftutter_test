part of 'offer_sale_view.dart';

class _OfferSaleMobile extends StatelessWidget {
  const _OfferSaleMobile({
    Key? key,
    required this.keyForm,
    required this.amountDLYCtrl,
    required this.marginCtrl,
    required this.infoPlusOfferCtrl,
    required this.accountNumCtrl,
    required this.docNumCtrl,
    required this.nameTitularAccountCtrl,
    required this.cancelSecretCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController amountDLYCtrl;
  final TextEditingController marginCtrl;
  final TextEditingController infoPlusOfferCtrl;
  final TextEditingController accountNumCtrl;
  final TextEditingController docNumCtrl;
  final TextEditingController nameTitularAccountCtrl;

  final TextEditingController cancelSecretCtrl;

  @override
  Widget build(BuildContext context) {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OfferSaleViewModel viewModel = context.watch<OfferSaleViewModel>();
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body
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
        body: Column(children: <Widget>[
          const AppbarCircles(hAppbar: hAppbar),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    color: LdColors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Oferta de venta',
                          style: textTheme.subtitleBlack.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Ingresa la informacion de la publicación.',
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
                              viewModel.completeEditMargin(marginCtrl.text),
                          validator: (String? value) =>
                              viewModel.validatorNotEmpty(value),
                          controller: marginCtrl,
                          changeFillWith: !viewModel.status.isMarginEmpty,
                          style: const TextStyle(
                            color: LdColors.orangePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          hintText: '0 COP',
                          hintStyle: TextStyle(
                            color: LdColors.orangePrimary.withOpacity(0.7),
                            fontSize: 18,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            NumericalRangeFormatter(max: 3, min: 0),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\,?\d{0,2}')),
                            // FilteringTextInputFormatter.deny(RegExp(r'[ -]')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          '¿Cuantos DLYCOP vas a vender?*',
                          style: textTheme.textBlack,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OrangeTableSale(
                          onChange: (_) {
                            viewModel.calculateTotalMoney(
                              marginCtrl.text,
                              amountDLYCtrl.text,
                            );
                          },
                          validator: (String? value) =>
                              viewModel.validatorNotEmpty(value),
                          textTheme: textTheme,
                          controller: amountDLYCtrl,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Bancos para recibir el pago',
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
                          'Banco *',
                          hintText: 'Seleciona tu banco',
                          validator: (String? value) =>
                              viewModel.validatorNotEmpty(value),
                          changeFillWith: viewModel.status.selectedBank != null,
                          value: viewModel.status.selectedBank?.id,
                          onChanged: (String? idBank) =>
                              viewModel.bankSelected(idBank!),
                          optionItems:
                              viewModel.status.listBanks.data.map((Bank item) {
                            return DropdownMenuItem<String>(
                              value: item.id,
                              child: Text(item.description),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (viewModel.status.selectedBank != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 32,
                            ),
                            decoration: BoxDecoration(
                              color: LdColors.whiteDark,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: <Widget>[
                                DropdownCustom(
                                  'Tipo de cuenta',
                                  hintText: 'seleciona el tipo',
                                  validator: (String? value) =>
                                      viewModel.validatorNotEmpty(value),
                                  value:
                                      viewModel.status.selectedAccountType?.id,
                                  changeFillWith:
                                      viewModel.status.selectedAccountType !=
                                          null,
                                  onChanged: (String? idDocType) =>
                                      viewModel.accountTypeSelected(idDocType!),
                                  optionItems: viewModel
                                      .status.listAccountType.data
                                      .map((DocType item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(item.description),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                InputTextCustom(
                                  '# cuenta',
                                  hintText: 'Escribe el número',
                                  maxLength: 20,
                                  validator: (String? value) =>
                                      viewModel.validatorNotEmpty(value),
                                  onChange: (String accountNum) => viewModel
                                      .changeAccountNumInput(accountNum),
                                  controller: accountNumCtrl,
                                  changeFillWith:
                                      !viewModel.status.isAccountNumEmpty,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                DropdownCustom(
                                  'Tipo de documento',
                                  hintText: 'Seleciona el tipo',
                                  value: viewModel.status.selectedDocType?.id,
                                  validator: (String? value) =>
                                      viewModel.validatorNotEmpty(value),
                                  changeFillWith:
                                      viewModel.status.selectedDocType != null,
                                  onChanged: (String? idTypeDoc) =>
                                      viewModel.docTypeSelected(idTypeDoc!),
                                  optionItems: viewModel
                                      .status.listDocsType.data
                                      .map((DocType item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(item.description),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                InputTextCustom(
                                  '# documento',
                                  hintText: 'Escribe el número',
                                  controller: docNumCtrl,
                                  validator: (String? value) =>
                                      viewModel.validatorNotEmpty(value),
                                  onChange: (String numberDoc) =>
                                      viewModel.changeDocNumUser(numberDoc),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  changeFillWith:
                                      !viewModel.status.isDocNumUserEmpty,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                InputTextCustom(
                                  'Nombre del titular de la cuenta',
                                  hintText: 'Escribe el nombre',
                                  validator: (String? value) =>
                                      viewModel.validatorNotEmpty(value),
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z ]')),
                                  ],
                                  onChange: (String name) =>
                                      viewModel.changeNameTitularAccount(name),
                                  changeFillWith: !viewModel
                                      .status.isNameTitularAccountEmpty,
                                  controller: nameTitularAccountCtrl,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        PrimaryButtonCustom(
                          'Agregar Banco',
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
                          maxLength: 250,
                          minLines: 5,
                          //Normal textInputField will be displayed
                          maxLines: 5,
                          // when user presses enter it will adapt to it
                          decoration: const InputDecoration(
                              hintText:
                                  'Ingresa informacion adicional para los compradores...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputTextCustom(
                          'Establece una palabra secreta para asegurar tus recursos',
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
                            color: LdColors.grayButton,
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
                          onPressed: () {
                            if (keyForm.currentState!.validate()) {
                              viewModel.createOfferSale(context,
                                  // userId: '96a6a171-641e-4103-8909-77ccd92d41eb',// juanP@
                                  userId:
                                      dataUserProvider.getDataUserLogged!.id,
                                  docNum: docNumCtrl.text,
                                  margin: marginCtrl.text,
                                  accountTypeId:
                                      viewModel.status.selectedAccountType!.id,
                                  accountNum: accountNumCtrl.text,
                                  nameTitularAccount:
                                      nameTitularAccountCtrl.text,
                                  bankId: viewModel.status.selectedBank!.id,
                                  amountDLY: amountDLYCtrl.text,
                                  infoPlusOffer: infoPlusOfferCtrl.text,
                                  docType: viewModel.status.selectedDocType!.id,
                                  wordSecret: cancelSecretCtrl.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
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
  final String? value;
  final String? Function(String?)? validator;
  bool? changeFillWith = false;

  @override
  Widget build(BuildContext context) {
    final OfferSaleViewModel viewModel = context.watch<OfferSaleViewModel>();
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
          validator: validator,
          value: value,
          decoration: InputDecoration(
            filled: changeFillWith,
            fillColor: LdColors.grayBorder,
            hintText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: LdColors.orangePrimary),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            // filled: changeFillWith != null ,
          ),
          items: optionItems,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
