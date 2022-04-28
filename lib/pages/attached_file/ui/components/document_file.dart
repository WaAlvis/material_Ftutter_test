part of '../attached_file_view.dart';

class DocumentFile extends StatefulWidget {
  const DocumentFile({Key? key, required this.file}) : super(key: key);
  final Uint8List file;

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: LdColors.grayLight,
            ),
            height: 400,
            width: 400,
            child: Stack(
              children: <Widget>[
                Center(
                  child: SvgPicture.asset(
                    LdAssets.buyNoOffer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () async {
        viewModel.saveFile(widget.file);
      },
    );
  }
}
