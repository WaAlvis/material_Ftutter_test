part of 'delete_account_view.dart';

class DeleteAccountWeb extends StatelessWidget {
  const DeleteAccountWeb({
    Key? key,
    required this.keyForm,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;

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
