part of 'home_view.dart';

class _LoginPhoneSaveMobile extends StatelessWidget {
  const _LoginPhoneSaveMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage(LdAssets.logo),
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
