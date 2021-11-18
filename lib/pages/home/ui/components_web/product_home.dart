part of '../home_view.dart';

class _ProductHome extends StatelessWidget {
  const _ProductHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 70),
      color: LdColors.whiteGray,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Producto',
                  style: textTheme.textBigBlack.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          style: textTheme.titleBigBlack,
                          text: 'Tus ',
                        ),
                        TextSpan(
                          style: textTheme.titleBigYellow,
                          text: 'DLY COP ',
                        ),
                        TextSpan(
                          style: textTheme.titleBigBlack,
                          text: 'al alcance de tu mano',
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  'Verifica tu cuenta, obtén fondos y realiza un seguimiento de tus activos en todas sus pantallas. Ya sea tu primera o milésima inversión, tenemos las herramientas ideales para ti.',
                  style: textTheme.textBigBlack.copyWith(
                    color: LdColors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Container(
                  width: 610,
                  height: 110,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(22),
                    ),
                    color: LdColors.black,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text(
                        'Nuevos inversores',
                        style: textTheme.textBigWhite.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Hacemos que sea fácil entender y comprar tus primeras DLY COP.',
                        style: textTheme.textWhite,
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                // Rectangle 10
                Container(
                  width: 610,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: LdColors.yellow,
                  ),
                  child: Text(
                    'Empieza a comprar y vender DLY COP',
                    style: textTheme.textBlack.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 35),
          Expanded(
            child: Container(
              width: 787,
              height: 470,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(28),
                ),
                color: LdColors.grayLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
