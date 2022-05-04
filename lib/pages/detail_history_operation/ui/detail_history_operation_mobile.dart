part of 'detail_history_operation_view.dart';

class DetailHistoryOperationMobile extends StatelessWidget {
  const DetailHistoryOperationMobile({
    Key? key,
    required this.keyForm,
    required this.item,
    // required this.scrollCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final DataUserAdvertisement item;

  // final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context) {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final DetailHistoryOperationViewModel viewModel =
        context.watch<DetailHistoryOperationViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 150;
    final double hBody = size.height - hAppbar;
    final TextStyle styleGrayText = textTheme.textGray.copyWith(fontSize: 14);
    final bool isBuying =
        dataUserProvider.getDataUserLogged!.nickName == item.user.nickName;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      appBar: const LdAppbar(
        title: 'Detalle',
        withBackIcon: true,
      ),
      body: Column(
        children: <Widget>[
          const AppbarCircles(hAppbar: hAppbar),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 34,
                ),
                constraints: BoxConstraints(minHeight: hBody),
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _operationType(
                        textTheme, dataUserProvider, styleGrayText, isBuying),
                    RowInfoPartner(
                      textTheme,
                      styleGrayText,
                      isBuying: isBuying,
                      item: item,
                      onPressed: () => viewModel.goProfileSeller(
                        context,
                      ),
                    ),
                    _rowAmount(
                      textTheme,
                      viewModel,
                      styleGrayText,
                      amountIn: _TypeMoney.dlycop,
                      amountValue: item.advertisement.valueToSell,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _relationMargin(textTheme, styleGrayText),
                    const SizedBox(
                      height: 24,
                    ),
                    _rowAmount(
                      textTheme,
                      viewModel,
                      styleGrayText,
                      amountIn: _TypeMoney.cop,
                      amountValue: item.advertisement.valueToSell,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _dateOperation(
                      styleGrayText,
                      viewModel,
                      textTheme,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _operationType(
    TextTheme textTheme,
    DataUserProvider dataUserProvider,
    TextStyle styleGrayText,
    bool isBuying,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (isBuying)
          Text(
            'Venta de DLYCOP',
            style: textTheme.textBlack.copyWith(
              color: LdColors.orangeWarning,
              fontWeight: FontWeight.w700,
            ),
          )
        else
          Text(
            'Compra de DLYCOP',
            style: textTheme.textBlack.copyWith(
              color: LdColors.green,
              fontWeight: FontWeight.w700,
            ),
          ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '# referencia: ${item.advertisement.reference}',
          style: styleGrayText,
        ),
      ],
    );
  }

  Column _dateOperation(TextStyle styleGrayText,
      DetailHistoryOperationViewModel viewModel, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Fecha',
          style: styleGrayText,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          viewModel.dateOperation(
            item.advertisement.creationDate,
          ),
          style: textTheme.textSmallBlack.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Column _relationMargin(TextTheme textTheme, TextStyle styleGrayText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Valor',
          style: styleGrayText,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '1 DLYCOP ≈ ${item.advertisement.margin} COP',
          style: textTheme.textSmallBlack,
        ),
      ],
    );
  }

  Column _rowAmount(
    TextTheme textTheme,
    DetailHistoryOperationViewModel viewModel,
    TextStyle grayText, {
    required _TypeMoney amountIn,
    required String amountValue,
  }) {
    final TextStyle styleBlackAmount = textTheme.textBigBlack.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          amountIn == _TypeMoney.cop ? 'Cantidad en COP' : 'Cantidad en DLYCOP',
          style: grayText,
        ),
        const SizedBox(
          height: 8,
        ),
        if (amountIn == _TypeMoney.cop)
          Text(
            '= ${viewModel.calculateCopTotal(item)} COP',
            style: styleBlackAmount,
          )
        else
          Row(
            children: <Widget>[
              Text(
                NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: '',
                  locale: 'IT',
                ).format(double.parse(amountValue)),
                style: styleBlackAmount,
              ),
              const SizedBox(
                width: 8,
              ),
              SvgPicture.asset(
                LdAssets.dlycopIconBlack,
                height: 33,
              )
            ],
          ),
      ],
    );
  }
}

class RowInfoPartner extends StatelessWidget {
  const RowInfoPartner(
    this.textTheme,
    this.styleGrayText, {
    Key? key,
    required this.isBuying,
    required this.item,
    this.onPressed,
  }) : super(key: key);
  final TextStyle styleGrayText;
  final TextTheme textTheme;
  final DataUserAdvertisement item;
  final void Function()? onPressed;
  final bool isBuying;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            isBuying ? 'Comprador' : 'Vendedor',
            style: styleGrayText,
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.account_circle,
                        size: 33,
                        color: LdColors.orangePrimary,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            //TODO obtener el usaurio para las ventas e ir a ver su perfil
                            item.user.nickName,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(width: 2,),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    color: LdColors.blackText,
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: LdColors.orangePrimary,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            isBuying
                                ? item.user.rateSeller.toString()
                                : item.user.rateBuyer.toString(),
                          ),
                        ],
                      ),
                      // const Spacer(),
                      const SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          color: LdColors.blackText,
                        ),
                      ),
                      // const Spacer(),
                      TextButton(
                        onPressed: onPressed,
                        child: const Text(
                          'Ver perfil',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: LdColors.orangePrimary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum _TypeMoney { dlycop, cop }
