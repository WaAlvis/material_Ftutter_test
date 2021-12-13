part of 'register_email_view.dart';

class _RegisterMobile extends StatelessWidget {
  const _RegisterMobile({
    Key? key,
    required this.keyForm,
    required this.emailCtrl,

  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController emailCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: LdColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //toolbarHeight: size.height * 0.13,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0, // 2
        title: Text(
          'Crear cuenta',
          style: textTheme.textWhite,
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width,
            color: LdColors.blackBackground,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                // Esto es el circulo, ideal volverlo widget
                Positioned(
                  right: 0,
                  child: SizedBox(
                    // El tamaño depende del tamaño de la pantalla
                    width: (size.width)/4,
                    height: (size.width)/4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width)*2/4,
                    height: (size.width)*2/4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width)*3/4,
                    height: (size.width)*3/4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: size.height * 0.15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Crear mi cuenta',
                        style: textTheme.textBigWhite,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Para continuar ingresa tu correo electronico.',
                        style: textTheme.textSmallWhite.copyWith(
                          color: LdColors.grayBg,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: (size.width - 32)*1/3,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: LdColors.orangePrimary,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
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
                    controller: emailCtrl,
                    hintText: 'ejemplo@correo.com',
                  ),
                  const Spacer(),
                  PrimaryButtonCustom(
                    'Ingresar',
                    onPressed: () => viewModel.goValidateEmail(context, emailCtrl.text),
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
