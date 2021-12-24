part of 'register_email_view.dart';

class _RegisterWeb extends StatelessWidget {
  const _RegisterWeb({
    Key? key,
    required this.keyForm,
    required this.isBuy,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const LdAppbar(title:'Test'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
              color: LdColors.whiteGray,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[CardRegister(), LdFooter()],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
