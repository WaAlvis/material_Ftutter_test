part of '../home_view.dart';

class _TableHome extends StatelessWidget {
  const _TableHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(17),
        ),
        border: Border.all(color: LdColors.black),
        color: LdColors.white,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Comprar DLYs online en Colombia',
            style: textTheme.subtitleBlack,
            textAlign: TextAlign.left,
          ),
          Table(
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  Text(
                    'Vendedor',
                    style: textTheme.textGray,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Puntuación',
                    style: textTheme.textGray,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Forma de pago',
                    style: textTheme.textGray,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Precio/DLY COP',
                    style: textTheme.textGray,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Límites',
                    style: textTheme.textGray,
                    textAlign: TextAlign.left,
                  ),
                  const Text(''),
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
                    '164,697,830.19 COP ',
                    style: textTheme.textGreen,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '50,000 - 220,024 COP	 ',
                    style: textTheme.textGreen,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    width: 100,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: LdColors.black,
                    ),
                    child: Text(
                      'Comprar',
                      style: textTheme.textBigWhite,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
