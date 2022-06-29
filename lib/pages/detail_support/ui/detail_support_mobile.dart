part of 'detail_support_view.dart';

class DetailSupportMobile extends StatelessWidget {
  const DetailSupportMobile(
      // this.nickNameCtrl,
      {
    Key? key,
    required this.keyForm,

    // required this.scrollCtrl,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  // final TextEditingController nickNameCtrl;

  @override
  Widget build(BuildContext context) {
    final DetailSupportViewModel viewModel =
        context.watch<DetailSupportViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 120;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      body: Column(
        children: <Widget>[
          AppBarBigger(
            title: 'Detalles del caso',
            hAppbar: hAppbar,
            textTheme: textTheme,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                width: size.width,
                constraints: BoxConstraints(minHeight: hBody),
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //TODO implement detail suport case
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SvgPicture.asset(
                            LdAssets.createOffer,
                            height: 204,
                            width: 204,
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Text(
                            'Descripcion:',
                            style: textTheme.textBlack.copyWith(
                              color: LdColors.orangeWarning,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            viewModel.advertisement.description,
                            style: textTheme.textBlack.copyWith(
                              color: LdColors.grayLight,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Usuario de la publicacion \n${viewModel.advertisement.userPublishNickname}',
                            style: textTheme.textBlack.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Fecha de la publicacion \n${viewModel.advertisement.datePublish}',
                            style: textTheme.textBlack.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Fecha de la solucion \n ${viewModel.advertisement.dateSolution == '1/1/0001 12:00:00 AM' ? 'Su caso esta en proceso' : viewModel.advertisement.dateSolution}',
                            style: textTheme.textBlack.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Correo asociado al caso \n${viewModel.advertisement.emailUserPublish}',
                            style: textTheme.textBlack.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Estimado usuario La gestión de su caso será informado por el email registrado asegurece de haberlo registrado correctamente para el seguimiento de su caso',
                            style: textTheme.textBlack.copyWith(
                              fontSize: 16,
                              color: LdColors.blackText,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
