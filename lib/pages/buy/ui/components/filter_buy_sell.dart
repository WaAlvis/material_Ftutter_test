part of '../buy_sell_view.dart';

class _FilterBuySell extends StatelessWidget {
  const _FilterBuySell({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    Widget _titleCellTable(String title){

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: textTheme.textGray,
          textAlign: TextAlign.left,
        ),
      );
    }

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
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Comprar DLYs online en Colombia',
                style: textTheme.subtitleBlack,
                textAlign: TextAlign.left,
              ),
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    _titleCellTable('Vendedor'),
                    _titleCellTable('Puntuación'),
                    _titleCellTable('Forma de pago'),
                    _titleCellTable('Precio/DLY COP'),
                    _titleCellTable('Límites'),
                    _titleCellTable('')
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Text(
                      'nashira60 ',
                      style: textTheme.textBlue,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '(100+; 99%) ',
                      style: textTheme.textBlack,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Transferencias con un banco específico: bancolombia ',
                      style: textTheme.textBlack,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '164,697.19 COP ',
                      style: textTheme.textGreen,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '5,000 - 22,024 COP	 ',
                      style: textTheme.textGreen,
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 30,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: LdColors.black,
                      ),
                      child: Text(
                        isBuy ? 'Comprar' : 'Vender',
                        style: textTheme.textBigWhite.copyWith(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
