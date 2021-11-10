part of 'validate_email_view.dart';

class _ValidateEmailWeb extends StatelessWidget {

  const _ValidateEmailWeb({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
    required this.isBuy,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;
  final bool isBuy;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final ValidateEmailViewModel viewModel = context.watch<ValidateEmailViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const LdAppbar('Test'),
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
                  children: const <Widget>[
                    _CardRegister(),
                    LdFooter()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
