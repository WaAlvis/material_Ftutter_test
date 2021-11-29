part of 'offert_sale_view.dart';

class _OffertSaleMobile extends StatelessWidget {
  const _OffertSaleMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
    required this.userCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;
  final TextEditingController userCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OffertSaleViewModel viewModel = context.watch<OffertSaleViewModel>();
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: LdColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'Ingresa la informacion de la publicacion.',
                style: textTheme.textBlack,
              ),
              const SizedBox(
                height: 24,
              ),
              InputTextCustom('Valor de los DLYCOP',
                  style: textTheme.textBigBlack, hintText: '0'),
              const SizedBox(
                height: 24,
              ),
              Text(
                '¿Cuantos DLYCOP vas a vender?*',
                style: textTheme.textBigBlack,
              ),
              const SizedBox(
                height: 20,
              ),
              OrangeTableSummary(textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}

class OrangeTableSummary extends StatelessWidget {
  const OrangeTableSummary({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
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
              Text(
                '0',
                style: textTheme.subtitleWhite,
              ),
              SvgPicture.asset(LdAssets.dlycop_icon),
            ],
          ),
          const SizedBox(
            height: 5,
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
            secondText: '1 DLY ≈ 1 COP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Fee(1%)',
            secondText: '0 DLYCOP',
          ),
          const SizedBox(
            height: 5,
          ),
          rowOrangeTable(
            firstText: 'Total',
            secondText: '0 DLYCOP',
          ),
        ],
      ),
    );
  }

  Row rowOrangeTable({required String firstText, required String secondText}) {
    TextStyle style = textTheme.textWhite.copyWith(
        color: LdColors.grayBg.withOpacity(0.6), fontWeight: FontWeight.w100);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          firstText,
          style: style,
        ),
        Text(
          secondText,
          style: style,
        ),
      ],
    );
  }
}
