part of '../offert_sale_view.dart';

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
  final String? Function(String?)?  validator;
  final TextEditingController? controller;
  final void Function(String)? onChange;

  // final String dlyCopValue;

  @override
  Widget build(BuildContext context) {
    final OffertSaleViewModel viewModel = context.watch<OffertSaleViewModel>();

    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: LdColors.orangePrimary),
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
                  ),
                ),
              ),
              SvgPicture.asset(LdAssets.dlycopIcon),
            ],
          ),
          const Divider(
            thickness: 1,
            color: LdColors.whiteDark,
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Valor',
            secondText: '1 DLY ≈ ${viewModel.status.costDLYtoCOP} COP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Fee(1%)',
            secondText: '${viewModel.status.feeMoney} DLYCOP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Total',
            secondText: '${viewModel.status.totalMoney} DLYCOP',
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
        overflow: TextOverflow.ellipsis);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          firstText,
          style: style,
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Container(
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
