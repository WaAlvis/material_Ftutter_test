part of 'register_email_view.dart';

class _RegisterMobile extends StatelessWidget {
  const _RegisterMobile({
    Key? key,
    required this.keyForm,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        title: Text(
          'Crear cuenta',
          style: textTheme.textBigWhite,
        ),
        centerTitle: true,
        elevation: 0, // 2
      ),
      backgroundColor: LdColors.green,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              color: LdColors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const QuarterCircle(
                    circleAlignment: CircleAlignment.bottomRight,
                    color: LdColors.grayLight,
                  ),
                  Text(
                    'Crear mi cuenta',
                    style: textTheme.textBigWhite,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Para continuar ingresa tu correo electronico.',
                    style: textTheme.textSmallWhite.copyWith(
                      color: LdColors.grayBg,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: <Widget>[
                  InputTextCustom(
                    'Correo electronico',
                    textTheme: textTheme,
                    hintText: 'ejemplo@correo.com',
                  ),
                  const Spacer(),
                  PrimaryButton(
                    'Ingresar',
                    onPressed: () => viewModel.goValidateEmail(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
