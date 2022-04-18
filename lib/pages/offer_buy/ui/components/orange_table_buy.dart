part of '../offer_buy_view.dart';

class AmountOrangeTableBuy extends StatelessWidget {
  const AmountOrangeTableBuy({
    Key? key,
    required this.textTheme,
    this.controller,
    this.onlyIntNum = false,
    this.onChange,
    this.validator,

    // this.dlyCopValue = '0',
  }) : super(key: key);

  final void Function(String)? onChange;
  final TextTheme textTheme;
  final bool onlyIntNum;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  // final String dlyCopValue;

  @override
  Widget build(BuildContext context) {
    final OfferBuyViewModel viewModel = context.watch<OfferBuyViewModel>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: LdColors.orangePrimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
          const SizedBox(
            height: 5,
          ),
          Text(
            '≈ ${viewModel.status.totalMoney} COP',
            style: textTheme.textWhite.copyWith(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
