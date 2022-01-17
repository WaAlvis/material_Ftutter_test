part of 'offert_sale_view.dart';

class _OffertSaleMobile extends StatelessWidget {
  const _OffertSaleMobile({
    Key? key,
    required this.keyForm,
    required this.amountDLYCtrl,
    required this.marginCtrl,
    required this.infoPlusOffertCtrl,
    required this.accountNumCtrl,
    required this.docNumCtrl,
    required this.nameTitularAccountCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController amountDLYCtrl;
  final TextEditingController marginCtrl;
  final TextEditingController infoPlusOffertCtrl;
  final TextEditingController accountNumCtrl;
  final TextEditingController docNumCtrl;
  final TextEditingController nameTitularAccountCtrl;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OffertSaleViewModel viewModel = context.watch<OffertSaleViewModel>();
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body
    const double hAppbar = 100;
    final double hBody = size.height - hAppbar;

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
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
          Container(
            width: size.width,
            color: LdColors.blackBackground,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                // Esto es el circulo, ideal volverlo widget
                Positioned(
                  right: 0,
                  child: SizedBox(
                    // El tamaño depende del tamaño de la pantalla
                    width: (size.width) / 4,
                    height: (size.width) / 4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width) * 2 / 4,
                    height: (size.width) * 2 / 4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width) * 3 / 4,
                    height: (size.width) * 3 / 4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                const SizedBox(
                  height: hAppbar,
                ),
              ],
            ),
          ),
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
                        InputTextCustom('Valor de los DLYCOP*',
                            onChange: (_) => viewModel.calculateTotalMoney(
                                  marginCtrl.text,
                                  amountDLYCtrl.text,
                                ),
                            onTap: () => marginCtrl.text =
                                viewModel.resetValueMargin(marginCtrl.text),
                            onEditingComplete: () => marginCtrl.text =
                                viewModel.completeEditMargin(marginCtrl.text),
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
                                fontSize: 18),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(RegExp(r'[. -]')),
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true)),
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
                                  value: viewModel.status.selectedAccountType?.id,
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
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                DropdownCustom(
                                  'Tipo de documento',
                                  hintText: 'Seleciona el tipo',
                                  value: viewModel.status.selectedDocType?.id,
                                  changeFillWith:
                                      viewModel.status.selectedDocType != null,
                                  onChanged: (String? idTypeDoc) =>
                                      viewModel.docTypeSelected(idTypeDoc!),
                                  optionItems: viewModel.status.listDocsType.data
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
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                InputTextCustom('Nombre del titular de la cuenta',
                                    hintText: 'Escribe el nombre'),
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
                          controller: infoPlusOffertCtrl,
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
                                Icons.timer,
                                size: 70,
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
                        PrimaryButtonCustom('Crear oferta de venta',
                            onPressed: () {
                          if (keyForm.currentState!.validate()) {
                            viewModel.postCreateOffert(
                              context,
                              userId: userProvider.getUserLogged!.id,
                              docNumCtrl: docNumCtrl,
                              marginCtrl: marginCtrl,
                              accountTypeId:
                                  viewModel.status.selectedAccountType!.id,
                              accountNumCtrl: accountNumCtrl,
                              nameTitularAccountCtrl: nameTitularAccountCtrl,
                              bankId: viewModel.status.selectedBank!.id,
                              amountDLYCtrl: amountDLYCtrl,
                              infoPlusOffertCtrl: infoPlusOffertCtrl,
                              docType: viewModel.status.selectedDocType!.id,
                            );
                          }
                        }),
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
    // this.styleLabel,
    // this.styleHint,
    // this.suffixIcon,
  }) : super(key: key);

  final String data;
  final String hintText;
  final List<DropdownMenuItem<String>>? optionItems;
  final void Function(String?)? onChanged;
  final String? value;
  bool? changeFillWith = false;

  @override
  Widget build(BuildContext context) {
    final OffertSaleViewModel viewModel = context.watch<OffertSaleViewModel>();
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
            filled: changeFillWith,
            fillColor: LdColors.grayBorder,
            hintText: hintText,
            border: const OutlineInputBorder(
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
