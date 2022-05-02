part of '../attached_file_view.dart';

class DocumentFile extends StatefulWidget {
  const DocumentFile({Key? key, required this.file}) : super(key: key);
  final Uint8List? file;

  @override
  State<DocumentFile> createState() => _DocumentFileState();
}

class _DocumentFileState extends State<DocumentFile> {
  @override
  Widget build(BuildContext context) {
    final AttachedFileViewModel viewModel =
        context.watch<AttachedFileViewModel>();
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: LdColors.grayLight,
            ),
            height: 400,
            width: 400,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Column(
                  children: [
                    SvgPicture.asset(
                      LdAssets.downloadFile,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Descargar archivo PDF')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () async {
        viewModel.saveFile(widget.file!);
      },
    );
  }
}
