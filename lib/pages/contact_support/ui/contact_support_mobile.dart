part of 'contact_support_view.dart';

class _ContactSupportMobile extends StatelessWidget {
  const _ContactSupportMobile({
    Key? key,
    required this.descriptionCtrl,
    required this.mobileCtrl,
  }) : super(key: key);
  final TextEditingController descriptionCtrl;
  final TextEditingController mobileCtrl;

  @override
  Widget build(BuildContext context) {
    const double hAppbar = 100;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      appBar: const LdAppbar(title: 'Servicio al cliente'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AppbarCircles(hAppbar: hAppbar),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(minHeight: size.height - hAppbar),
                padding: const EdgeInsets.all(18.0),
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: _ContactSupportBody(
                  descriptionCtrl: descriptionCtrl,
                  mobileCtrl: mobileCtrl,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ContactSupportBody extends StatelessWidget {
  const _ContactSupportBody({
    Key? key,
    required this.descriptionCtrl,
    required this.mobileCtrl,
  }) : super(key: key);
  final TextEditingController descriptionCtrl;
  final TextEditingController mobileCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ContactSupportViewModel viewModel =
        context.read<ContactSupportViewModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Oferta de ${viewModel.status.isBuy ? 'venta' : 'compra'}',
              style: textTheme.subtitleBlack.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '# referencia: 000101',
              style: textTheme.textGray,
            ),
            const SizedBox(height: 20),
            Text(
              'Abrir caso de soporte',
              style: textTheme.textBigBlack.copyWith(
                color: LdColors.orangePrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Detalle el inconveniente que ha presentado. En el transcurso de las próximas 24 horas hábiles, uno de nuestros agentes te responderá.',
              style: textTheme.textGray.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 25),
            Text(
              'Descripción del caso *',
              style: textTheme.textBlack,
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: descriptionCtrl,
              minLines: 5,
              maxLines: 5,
              maxLength: 250,
              validator: (String? description) =>
                  viewModel.validatorNotEmpty(description),
              decoration: const InputDecoration(
                hintText: 'Ingresa descripción',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ingrese un número de celular al cual nuestro agente pueda contactarlo en caso de requerirse.',
              style: textTheme.textGray.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            InputTextCustom(
              'Número de celular (opcional)',
              hintText: 'Ingresa el número',
              controller: mobileCtrl,
              onChange: (String mobile) => viewModel.changeMobile(mobile),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              changeFillWith: viewModel.status.mobile.isNotEmpty,
            ),
          ],
        ),
        PrimaryButtonCustom(
          'Enviar caso a soporte',
          onPressed: () {},
        ),
      ],
    );
  }
}
