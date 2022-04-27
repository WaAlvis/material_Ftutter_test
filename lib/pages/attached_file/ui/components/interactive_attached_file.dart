part of '../attached_file_view.dart';

class InteractiveAttachedFile extends StatefulWidget {
  const InteractiveAttachedFile(
      {Key? key,
      required this.fileDoc,
      required this.extensionFile,
      required this.bytes})
      : super(key: key);
  final String fileDoc;
  final String extensionFile;
  final Uint8List bytes;

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
        '${widget.fileDoc} ruta del archivo ${widget.extensionFile} extension del archivo');
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          width = 400 * details.scale.clamp(0.7, 10.0);
          height = 400 * details.scale.clamp(0.7, 10.0);
        });
      },
      child: Column(
        children: [
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
              child: widget.extensionFile == '' && widget.fileDoc == '' ||
                      widget.extensionFile == '.pdf'
                  ? Stack(
                      children: <Widget>[
                        Center(
                          child: SvgPicture.asset(
                            LdAssets.downloadFile,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Center()
                      ],
                    )
                  : widget.bytes != Uint8List(0)
                      ? widget.fileDoc == ''
                          ? Image.memory(widget.bytes)
                          : Image.file(
                              File(widget.fileDoc),
                              fit: BoxFit.cover,
                            )
                      : widget.fileDoc != '' && widget.bytes == Uint8List(0)
                          ? Image.file(
                              File(widget.fileDoc),
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              LdAssets.downloadFile,
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
