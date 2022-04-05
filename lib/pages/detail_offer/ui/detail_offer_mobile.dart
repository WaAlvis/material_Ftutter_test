part of 'detail_offer_view.dart';

class _DetailOfferMobile extends StatelessWidget {
  const _DetailOfferMobile({
    Key? key,
    required this.keyForm,
    required this.item,
    required this.infoPlusOfferCtrl,
    required this.accountNumCtrl,
    required this.docNumCtrl,
    required this.nameTitularAccountCtrl,
  }) : super(key: key);

  final Data item;
  final GlobalKey<FormState> keyForm;
  final TextEditingController infoPlusOfferCtrl;
  final TextEditingController accountNumCtrl;
  final TextEditingController docNumCtrl;
  final TextEditingController nameTitularAccountCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DetailOfferViewModel viewModel =
        context.watch<DetailOfferViewModel>();
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body
    const double hAppbar = 100;

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
          title: 'Detalles de la operación',
          // withBackIcon: false,
        ),
        body: Column(children: <Widget>[
          const AppbarCircles(hAppbar: hAppbar),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: size.height - hAppbar),
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            OperationHeader(
                              type: TypeOffer.buy,
                              ad: item.advertisement,
                              textTheme: textTheme,
                              size: size,
                            ),
                            const SizedBox(height: 20),
                            PublisherInformation(
                              user: item.user,
                              textTheme: textTheme,
                              size: size,
                            ),
                            const SizedBox(height: 30),
                            CardDetailOffer(
                              item: item,
                              textTheme: textTheme,
                              viewModel: viewModel,
                            ),
                            if (viewModel.status.isBuy)
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 12),
                                child: DropdownCustom(
                                  'Entidad *',
                                  hintText: 'Seleciona tu entidad',
                                  validator: (String? value) =>
                                      viewModel.validatorNotEmpty(value),
                                  changeFillWith:
                                      viewModel.status.selectedBank != null,
                                  value: viewModel.status.selectedBank?.id,
                                  onChanged: (String? idBank) =>
                                      viewModel.bankSelected(idBank!),
                                  optionItems: viewModel.status.listBanks.data
                                      .map((Bank item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(item.description),
                                    );
                                  }).toList(),
                                ),
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
                                      value: viewModel
                                          .status.selectedAccountType?.id,
                                      changeFillWith: viewModel
                                              .status.selectedAccountType !=
                                          null,
                                      onChanged: (String? idDocType) =>
                                          viewModel
                                              .accountTypeSelected(idDocType!),
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
                                      controller: accountNumCtrl,
                                      changeFillWith:
                                          accountNumCtrl.text.isNotEmpty,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'),
                                        ),
                                      ],
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    DropdownCustom(
                                      'Tipo de documento',
                                      hintText: 'Seleciona el tipo',
                                      value:
                                          viewModel.status.selectedDocType?.id,
                                      validator: (String? value) =>
                                          viewModel.validatorNotEmpty(value),
                                      changeFillWith:
                                          viewModel.status.selectedDocType !=
                                              null,
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
                                    InputTextCustom('# documento',
                                        hintText: 'Escribe el número',
                                        controller: docNumCtrl,
                                        validator: (String? value) =>
                                            viewModel.validatorNotEmpty(value),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        changeFillWith:
                                            docNumCtrl.text.isNotEmpty),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    InputTextCustom(
                                      'Nombre del titular de la cuenta',
                                      hintText: 'Escribe el nombre',
                                      validator: (String? value) =>
                                          viewModel.validatorNotEmpty(value),
                                      keyboardType: TextInputType.name,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z ]')),
                                      ],
                                      controller: nameTitularAccountCtrl,
                                      changeFillWith: nameTitularAccountCtrl
                                          .text.isNotEmpty,
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 30),
                            Text(
                              'Entidades',
                              style: textTheme.textGray.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              // TODO: Solicitar que el servicio retorne BankName
                              item.advertisement.advertisementPayAccount
                                  .map(
                                    (e) => /* '${e.bankId}, ' */ 'Bancolombia, Nequi.',
                                  )
                                  .toString()
                                  .replaceAll('(', '')
                                  .replaceAll(')', ''),
                              style: textTheme.textBlack,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Información adicional',
                              style: textTheme.textGray.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.advertisement.termsOfTrade.isEmpty
                                  ? 'No hay información adicional.'
                                  : item.advertisement.termsOfTrade,
                              style: item.advertisement.termsOfTrade.isEmpty
                                  ? textTheme.textGray
                                  : textTheme.textBlack,
                            ),
                          ],
                        ),
                        PrimaryButtonCustom(
                          'Separar oferta de compra DLYCOP',
                          onPressed: viewModel.onClickReserveDly,
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

class OperationHeader extends StatelessWidget {
  const OperationHeader({
    Key? key,
    required this.type,
    required this.ad,
    required this.textTheme,
    required this.size,
  }) : super(key: key);

  final TypeOffer type;
  final Advertisement ad;
  final TextTheme textTheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          type == TypeOffer.buy ? 'Comprar DLYCOP' : 'Vender DLYCOP',
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
              '# referencia: ${ad.id.substring(0, 5)}',
              style: textTheme.textGray,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 6,
              ),
              decoration: BoxDecoration(
                color: LdColors.orangePrimary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
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
                              ad.expiredDate,
                            )
                                .difference(
                                  DateTime.now(),
                                )
                                .inDays >
                            0
                        ? '${DateTime.fromMillisecondsSinceEpoch(
                            ad.expiredDate,
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

class PublisherInformation extends StatelessWidget {
  const PublisherInformation({
    Key? key,
    required this.user,
    required this.textTheme,
    required this.size,
  }) : super(key: key);

  final UserDataHome user;
  final TextTheme textTheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.account_circle,
          size: 30,
          color: LdColors.orangePrimary,
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: size.width * 0.25),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              user.nickName,
              style: textTheme.textSmallBlack,
            ),
          ),
        ),
        const Spacer(),
        const SizedBox(
          height: 28,
          child: VerticalDivider(color: LdColors.blackText),
        ),
        const Spacer(),
        const Icon(
          Icons.star,
          color: LdColors.orangePrimary,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          user.rateBuyer.toString(),
          style: textTheme.textSmallBlack,
        ),
        const Spacer(),
        const SizedBox(
          height: 28,
          child: VerticalDivider(
            color: LdColors.blackText,
          ),
        ),
        const Spacer(),
        Text(
          'Ver perfil',
          style: textTheme.textSmallBlack.copyWith(
            color: LdColors.orangePrimary,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
