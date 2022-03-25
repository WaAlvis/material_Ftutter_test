part of 'buy_sell_view.dart';

class _BuySellMobile extends StatelessWidget {
  const _BuySellMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.fill,
                image: AssetImage(LdAssets.logoWhiteOrange),
              ),
            ),
            child: const Text('Es una prueba mobile', style: TextStyle(color: LdColors.black),),
          ),
        ),
        Flexible(
          child: Container(),
        ),
      ],
    );
  }
}