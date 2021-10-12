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
              color: Color(0xffc4c4c4),
            ),
          ),
          Flexible(
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xff3e4462),
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                fontStyle:  FontStyle.normal,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      color: const Color(0xfffafafa),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 706,
              height: 716,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(28),
                ),
                color: Color(0xffc4c4c4),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Seguridad',
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'GTWalsheimPro',
                    fontStyle:  FontStyle.normal,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: TextStyle(
                          color: Color(0xff040505),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 65.0,
                        ),
                        text: 'Compra y vende tus ',
                      ),
                      TextSpan(
                        style: TextStyle(
                          color: Color(0xffe6e922),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 65.0,
                        ),
                        text: 'DLY COP ',
                      ),
                      TextSpan(
                        style: TextStyle(
                          color:  Color(0xff040505),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'GTWalsheimPro',
                          fontStyle:  FontStyle.normal,
                          fontSize: 65.0,
                        ),
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
