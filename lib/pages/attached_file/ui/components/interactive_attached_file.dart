part of '../attached_file_view.dart';

class InteractiveAttachedFile extends StatefulWidget {
  const InteractiveAttachedFile({
    Key? key,
    // required this.fileDoc,
    // required this.extensionFile,
    // required this.bytes
  }) : super(key: key);
  // final String fileDoc;
  // final String extensionFile;
  // final Uint8List bytes;

  @override
  State<InteractiveAttachedFile> createState() =>
      _InteractiveAttachedFileState();
}

class _InteractiveAttachedFileState extends State<InteractiveAttachedFile> {
  double? width;
  double? height;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final AttachedFileViewModel viewModel =
        context.watch<AttachedFileViewModel>();
    print(
      '${viewModel.status.filePath} ruta del archivo ${viewModel.status.extensionFile} extension del archivo ${viewModel.status.bytes?.isEmpty} archivo en bytes .${viewModel.status.extensionUrl}',
    );
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          width = 400 * details.scale.clamp(0.7, 10.0);
          height = 400 * details.scale.clamp(0.7, 10.0);
        });
      },
      child: Column(
        children: <Widget>[
          InteractiveViewer(
            maxScale: 5.0,
            minScale: 0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: LdColors.grayLight,
              ),
              height: 400,
              width: 400,
              child: (viewModel.status.extensionFile == '' &&
                          viewModel.status.filePath == null) ||
                      viewModel.status.extensionUrl == 'pdf'
                  ? Stack(
                      children: <Widget>[
                        Center(
                          child: viewModel.status.extensionUrl != 'pdf'
                              ? SvgPicture.asset(
                                  LdAssets.downloadFile,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.scaleDown,
                                )
                              : const Icon(Icons.picture_as_pdf, size: 50),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Center()
                      ],
                    )
                  : viewModel.status.bytes != null
                      ? viewModel.status.filePath == null
                          ? viewModel.status.extensionFile != '.pdf'
                              ? Image.memory(viewModel.status.bytes!)
                              : const Icon(Icons.picture_as_pdf, size: 50)
                          : Image.file(
                              File(viewModel.status.filePath ?? ''),
                              fit: BoxFit.cover,
                            )
                      : viewModel.status.filePath != null &&
                              viewModel.status.bytes == null
                          ? Image.file(
                              File(viewModel.status.filePath ?? ''),
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              LdAssets.downloadFile,
                              height: 100,
                              width: 100,
                              fit: BoxFit.scaleDown,
                            ),
            ),
          ),
        ],
      ),
      onTap: () {
        // Navigator.pop(context);
      },
    );
  }
}

void confirmBottomSheet(
  BuildContext context,
  AttachedFileViewModel viewModel, {
  bool isBuy = false,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
    builder: (BuildContext context) {
      final ImagePicker _picker = ImagePicker();

      return Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PrimaryButtonCustom(
                'Tomar foto',
                colorButton: LdColors.white,
                colorTextBorder: LdColors.orangePrimary,
                onPressed: () {
                  viewModel.getPhotoCamera(_picker, context);
                },
              ),
              PrimaryButtonCustom(
                'Adjuntar desde archivo',
                colorButton: LdColors.white,
                colorTextBorder: LdColors.orangePrimary,
                onPressed: () {
                  viewModel.getFile(context);
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      );
    },
  );
}
