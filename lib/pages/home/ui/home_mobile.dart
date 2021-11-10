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
    return SafeArea(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         Flexible(child: Container(color: Colors.blueAccent,),flex: 2,),
          Flexible(child: Container(),flex: 8,)
        ],
      ),
    );
  }
}
