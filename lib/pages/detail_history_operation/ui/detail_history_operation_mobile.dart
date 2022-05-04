part of 'detail_history_operation_view.dart';

class DetailHistoryOperationMobile extends StatelessWidget {
  const DetailHistoryOperationMobile({
    Key? key,
    required this.keyForm,
    required this.item,
    // required this.scrollCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final Operation item;

  // final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context) {
    final DetailHistoryOperationViewModel viewModel =
        context.watch<DetailHistoryOperationViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 150;
    final double hBody = size.height - hAppbar;
    final TextStyle styleGrayText = textTheme.textGray.copyWith(fontSize: 14);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      // appBar: const LdAppbar(
      //   title: 'Historial',
      //   withBackIcon: true,
      // ),
      body: Column(
        children: <Widget>[
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
                SizedBox(
                  height: hAppbar,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () => viewModel.goBack(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: LdColors.white,
                          ),
                        ),
                        Text(
                          'Detalle',
                          style: textTheme.textBigWhite,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                    _operationType(textTheme, styleGrayText),
                    RowInfoPartner(textTheme, styleGrayText,
                        item: item,
                        onPressed: () =>
                            viewModel.goProfileSeller(context,)),
                    _rowAmount(
                      textTheme,
                      styleGrayText,
                      amountIn: _TypeMoney.dlycop,
                      amountValue: item.amount,
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
                      styleGrayText,
                      amountIn: _TypeMoney.cop,
                      amountValue: item.amount,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _dateOperation(
                      styleGrayText,
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

  Column _operationType(TextTheme textTheme, TextStyle styleGrayText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (item.amount.contains('-'))
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
          '# referencia: 0130${item.margin}',
          style: styleGrayText,
        ),
      ],
    );
  }

  Column _dateOperation(TextStyle styleGrayText, TextTheme textTheme) {
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
          '04 de Noviembre a las 8:34 am',
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
          '1 DLYCOP ≈ ${item.margin} COP',
          style: textTheme.textSmallBlack,
        ),
      ],
    );
  }

  Column _rowAmount(
    TextTheme textTheme,
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
            '= $amountValue COP',
            style: styleBlackAmount,
          )
        else
          Row(
            children: <Widget>[
              Text(
                amountValue,
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
    required this.item,
    this.onPressed,
    Key? key,
  }) : super(key: key);
  final TextStyle styleGrayText;
  final TextTheme textTheme;
  final Operation item;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Comprador',
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
                            item.nickname,
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
                            item.rate != '0' ? item.rate : '4.5',
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
