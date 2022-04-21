part of '../attached_file_view.dart';

class InteractiveAttachedFile extends StatefulWidget {
  const InteractiveAttachedFile({Key? key, required this.fileDoc})
      : super(key: key);
  final String fileDoc;
  @override
  State<InteractiveAttachedFile> createState() =>
      _InteractiveAttachedFileState();
}

class _InteractiveAttachedFileState extends State<InteractiveAttachedFile> {
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
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
              color: LdColors.grayLight,
              height: 400,
              width: 400,
              child: Image.file(File(widget.fileDoc), fit: BoxFit.contain),
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

Widget _getWidget(XFile? fileDoc) {
  Widget _widget = const Text('No ha seleccionado una imagen');
  if (fileDoc == null) {
    return _widget = Image.file(File(LdAssets.downloadFile));
  }
  return _widget;
}
