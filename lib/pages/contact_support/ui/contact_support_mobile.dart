part of 'contact_support_view.dart';

class _ContactSupportMobile extends StatelessWidget {
  const _ContactSupportMobile({
    Key? key,
    required this.descriptionCtrl,
  }) : super(key: key);
  final TextEditingController descriptionCtrl;

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
                child: _ContactSupportBody(descriptionCtrl: descriptionCtrl),
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
  }) : super(key: key);
  final TextEditingController descriptionCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ContactSupportViewModel viewModel =
        context.read<ContactSupportViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Oferta de ${!viewModel.isbuy ? 'venta' : 'compra'}',
              style: textTheme.subtitleBlack.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '# referencia: ${viewModel.reference}',
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
              'NOTA: Toda la información respecto al caso será enviada a su correo electrónico con el que se encuentra registrado: ${dataUserProvider.getDataUserLogged?.email ?? ''}',
              style: textTheme.textGray.copyWith(fontSize: 16),
            ),
          ],
        ),
        PrimaryButtonCustom(
          'Enviar caso a soporte',
          onPressed: viewModel.onClickContactSupport,
        ),
      ],
    );
  }
}
