part of 'buy_sell_view.dart';

class _LoginPhoneSaveWeb extends StatelessWidget {
  const _LoginPhoneSaveWeb({
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
        const Flexible(
          child: Text('Web View'),
        ),
        Flexible(
          child: Container(),
        ),
      ],
    );
  }
}
