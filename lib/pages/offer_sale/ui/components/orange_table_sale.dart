part of '../offer_sale_view.dart';

class OrangeTableSale extends StatelessWidget {
  const OrangeTableSale({
    Key? key,
    required this.textTheme,
    this.onlyIntNum = false,
    this.controller,
    this.validator,
    this.onChange,
    // this.dlyCopValue = '0',
  }) : super(key: key);

  final TextTheme textTheme;
  final bool onlyIntNum;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChange;

  // final String dlyCopValue;

  @override
  Widget build(BuildContext context) {
    final OfferSaleViewModel viewModel = context.watch<OfferSaleViewModel>();

    final String? valueDlycop =
        controller?.text != '' ? controller?.text.replaceAll('.', '') : '0';

    final String totalDlycop = viewModel.getTotalDlycopSold(valueDlycop);
    final String totaCop = viewModel.getTotalCopToPay(valueDlycop);
    final String totaAd = viewModel.getTotalAddToPay(valueDlycop);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: LdColors.orangePrimary,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  onChanged: onChange,
                  controller: controller,
                  validator: validator,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorInputFormatter()
                  ],
                  keyboardType: TextInputType.number,
                  style: textTheme.subtitleWhite,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: textTheme.subtitleWhite,
                    counterText: '',
                  ),
                  maxLength: 11,
                ),
              ),
              SvgPicture.asset(LdAssets.dlycopIconWhite),
            ],
          ),
          const Divider(
            thickness: 1,
            color: LdColors.blackBackground,
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Valor',
            secondText: '1 DLYCOP ≈ ${viewModel.status.costDLYtoCOP} COP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            // TODO: El fee debe ser un servicio
            firstText: 'Fee (${LdConstants.fee * 100}%)',
            secondText: '${viewModel.status.feeMoney} DLYCOP',
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text('Detalle comprador', style: textTheme.textWhite),
              ),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: LdColors.blackBackground,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            // TODO: El fee debe ser un servicio
            firstText: 'Total DLYCOP',
            secondText: '$totalDlycop DLYCOP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Total COP',
            secondText: '$totaCop COP',
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text('Detalle vendedor', style: textTheme.textWhite),
              ),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: LdColors.blackBackground,
                ),
              ),
            ],
          ),
          rowOrangeTable(
            firstText: 'Total',
            secondText: '$totaAd DLYCOP',
          ),
        ],
      ),
    );
  }

  Widget rowOrangeTable(
      {required String firstText, required String secondText}) {
    final TextStyle style = textTheme.textWhite.copyWith(
      color: LdColors.grayBg,
      fontWeight: FontWeight.w100,
      overflow: TextOverflow.ellipsis,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          firstText,
          style: style,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              secondText,
              style: style,
            ),
          ),
        ),
      ],
    );
  }
}
