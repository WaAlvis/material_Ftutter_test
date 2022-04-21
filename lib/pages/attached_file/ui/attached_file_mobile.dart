part of 'attached_file_view.dart';

class _AttachedFileMobile extends StatelessWidget {
  late String _file = LdAssets.downloadFile;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AttachedFileViewModel viewModel =
        context.watch<AttachedFileViewModel>();
    viewModel.handlePermisos();
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body
    const double hAppbar = 100;
    final ImagePicker _picker = ImagePicker();
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus || !currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: LdColors.blackBackground,
        appBar: const LdAppbar(
          title: 'Detalles de la operación',
          // withBackIcon: false,
        ),
        body: Column(
          children: <Widget>[
            const AppbarCircles(hAppbar: hAppbar),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: size.height - hAppbar),
                  decoration: const BoxDecoration(
                    color: LdColors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: <Widget>[
                        OperationHeader(
                          textTheme: textTheme,
                          size: size,
                        ),
                        InteractiveAttachedFile(
                          fileDoc: viewModel.status.filePath ?? '',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PrimaryButtonCustom(
                          'Tomar foto',
                          onPressed: () {
                            viewModel.getPhotoCamera(_picker);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // PrimaryButtonCustom(
                        //   'Abrir galeria',
                        //   onPressed: () {
                        //     _getPhotoGallery(_picker);
                        //   },
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        PrimaryButtonCustom(
                          'Enviar comprobante',
                          onPressed: () async {
                            viewModel.attachFile(
                                'e44e3cfd-1366-435f-9cbd-b0d28eb62f4c',
                                'd399d1c8-a165-466e-a98e-0a69c176f5a3',
                                context);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
