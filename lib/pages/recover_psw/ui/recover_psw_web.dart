part of 'recover_psw_view.dart';

class _RecoverPswWeb extends StatelessWidget {

  const _RecoverPswWeb({
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
    final RecoverPswViewModel viewModel = context.watch<RecoverPswViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const LdAppbar(title: 'Test'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
              color: LdColors.whiteGray,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height - 100,
                  ),
                  const LdFooter()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
