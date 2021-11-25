part of 'personal_info_register_view.dart';

class _PersonalInfoRegisterWeb extends StatelessWidget {
  const _PersonalInfoRegisterWeb({
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
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height - 100,
                    child: const CardRegister(),
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
