part of 'home_view.dart';

class _HomeMobile extends StatelessWidget {
  const _HomeMobile({
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
            child: const Text(
              'Home, Es una prueba mobile',
              style: TextStyle(color: LdColors.black),
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () => locator<LdRouter>().goLogin(context),
          child: const Text('go Login'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => locator<LdRouter>().goRegister(context),
          child: const Text('go register'),
        ),
        Flexible(
          child: Container(
          ),
        ),
      ],
    );
  }
}
