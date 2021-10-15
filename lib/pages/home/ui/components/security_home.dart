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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 10),
          Container(
            width: 113,
            height: 113,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: LdColors.grayLight,
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                description,
                style: textTheme.textBlack,
                textAlign: TextAlign.left,
              ),
            ),
          )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 70),
      color: LdColors.whiteGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 666,
              height: 466,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28)),
                color: LdColors.grayLight,
              ),
            ),
          ),
          const SizedBox(width: 35),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Seguridad',
                  style: textTheme.textBigBlack.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: textTheme.titleBigBlack.copyWith(
                          fontSize: 48,
                        ),
                        text: 'Compra y vende tus ',
                      ),
                      TextSpan(
                        style: textTheme.titleBigYellow.copyWith(
                          fontSize: 48,
                        ),
                        text: 'DLY COP ',
                      ),
                      TextSpan(
                        style: textTheme.titleBigBlack.copyWith(
                          fontSize: 48,
                        ),
                        text: 'con confianza',
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _rowSection('Mantenemos tus depósitos seguros a través del almacenamiento fuera de línea, la supervisión de transacciones las 24 horas, los 7 días de la semana, y el cifrado de múltiples factores.'),
                const SizedBox(height: 5),
                _rowSection('Los períodos de inactividad son cosa de 2020. Sin períodos de inactividad en las transacciones, tus compras serán siempre tan valiosas como el oro.')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
