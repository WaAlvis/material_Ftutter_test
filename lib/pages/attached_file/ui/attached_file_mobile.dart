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
    print(' viewModel.status.isView  ${viewModel.status.isView}');
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
                        if (viewModel.status.extensionFile == '.pdf' &&
                            viewModel.status.isView == '1')
                          DocumentFile(
                            file: viewModel.status.bytes!,
                          )
                        else
                          InteractiveAttachedFile(
                            fileDoc: viewModel.status.filePath ?? '',
                            extensionFile: viewModel.extensionFile,
                            bytes: viewModel.status.bytes!,
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (viewModel.status.isView == '1')
                          Container()
                        else
                          PrimaryButtonCustom(
                            'Adjuntar comprobante',
                            colorButton: LdColors.white,
                            colorTextBorder: LdColors.orangePrimary,
                            onPressed: () {
                              // viewModel.getPhotoCamera(_picker);
                              confirmBottomSheet(
                                context,
                                viewModel,
                              );
                            },
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (viewModel.status.isView == '1')
                          Container()
                        else
                          PrimaryButtonCustom(
                            'Enviar comprobante',
                            colorButton: LdColors.white,
                            colorTextBorder: LdColors.orangePrimary,
                            onPressed: () async {
                              viewModel.attachFile(
                                viewModel.status.item,
                                viewModel.status.userId!,
                                context,
                              );
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
