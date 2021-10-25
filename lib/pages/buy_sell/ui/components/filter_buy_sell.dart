part of '../buy_sell_view.dart';

class _FilterBuySell extends StatelessWidget {
  const _FilterBuySell({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final BuySellViewModel viewModel = context.watch<BuySellViewModel>();
    final Size size = MediaQuery.of(context).size;

    final TextStyle blackText = textTheme.textBlack.copyWith(
      fontWeight: FontWeight.w500,
    );

    final TextStyle whiteText = textTheme.textWhite.copyWith(
      fontWeight: FontWeight.w500,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 15),
      color: LdColors.black,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          border: Border.all(color: LdColors.whiteDark),
          color: LdColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 270,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: LdColors.whiteDark,
                    ),
                    color: isBuy ? LdColors.black : LdColors.white,
                  ),
                  child: Text(
                    'Compra Rápida',
                    style: isBuy ? whiteText : blackText,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 270,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: LdColors.whiteDark,
                    ),
                    color: isBuy ? LdColors.white : LdColors.black,
                  ),
                  child: Text(
                    'Venta Rápida',
                    style: isBuy ? blackText : whiteText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 42,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: LdColors.whiteDark,
                      ),
                      color: LdColors.grayBg,
                    ),
                    child: Text(
                      'Cantidad',
                      style: textTheme.textBlack.copyWith(
                        fontWeight: FontWeight.w500,
                        color: LdColors.grayLight,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 70,
                  height: 42,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: LdColors.whiteDark,
                    ),
                    color: LdColors.grayBg,
                  ),
                  child: Text(
                    'COP',
                    style: textTheme.textBlack.copyWith(
                      fontWeight: FontWeight.w500,
                      color: LdColors.blackText,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    width: 170,
                    height: 42,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: LdColors.whiteDark,
                      ),
                      color: LdColors.grayBg,
                    ),
                    child: Text(
                      'Colombia',
                      style: textTheme.textBlack.copyWith(
                        fontWeight: FontWeight.w500,
                        color: LdColors.blackText,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    width: 270,
                    height: 42,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: LdColors.whiteDark,
                      ),
                      color: LdColors.grayBg,
                    ),
                    child: Text(
                      'Todas las ofertas online',
                      style: textTheme.textBlack.copyWith(
                        fontWeight: FontWeight.w500,
                        color: LdColors.blackText,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 120,
                  height: 42,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: LdColors.whiteDark,
                    ),
                    color: LdColors.black,
                  ),
                  child: Text(
                    'Buscar',
                    style: textTheme.textWhite.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
