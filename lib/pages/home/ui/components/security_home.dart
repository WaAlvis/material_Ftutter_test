part of '../home_view.dart';

class _SecurityHome extends StatelessWidget {
  const _SecurityHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    Widget _rowSection (String description) {

      return Row(
        children: <Widget>[
          Container(
            width: 173,
            height: 173,
            decoration: const BoxDecoration(
              color: LdColors.grayLight,
            ),
          ),
          Flexible(
            child: Text(
              description,
              style: textTheme.textBigBlack,
              textAlign: TextAlign.left,
            ),
          )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      color: LdColors.whiteGray,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 706,
              height: 716,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28)),
                color: LdColors.grayLight,
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Seguridad',
                  style: textTheme.textBigBlack,
                  textAlign: TextAlign.left,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: textTheme.titleBigBlack,
                        text: 'Compra y vende tus ',
                      ),
                      TextSpan(
                        style: textTheme.titleBigYellow,
                        text: 'DLY COP ',
                      ),
                      TextSpan(
                        style: textTheme.titleBigBlack,
                        text: 'con confianza',
                      )
                    ],
                  ),
                ),
                _rowSection('Mantenemos tus depósitos seguros a través del almacenamiento fuera de línea, la supervisión de transacciones las 24 horas, los 7 días de la semana, y el cifrado de múltiples factores.'),
                _rowSection('Los períodos de inactividad son cosa de 2020. Sin períodos de inactividad en las transacciones, tus compras serán siempre tan valiosas como el oro.')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
