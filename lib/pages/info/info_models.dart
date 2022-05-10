part of 'ui/info_view.dart';

// Image enum, needs to match the index with de imageList
enum ImageType {
  success,
  email,
}

List<String> imageList = <String>[
  LdAssets.infoOk,
  LdAssets.infoMail,
];

class InfoViewArguments {
  final String? pageTitle;
  final String? title;
  final Color? colorTitle;
  final String description;
  final ImageType imageType;
  final Widget customWidget;
  final bool hasActionButton;
  final String actionCaption;
  final VoidCallback? onAction;

  const InfoViewArguments({
    this.title,
    this.colorTitle,
    required this.description,
    this.imageType = ImageType.success,
    this.pageTitle,
    this.customWidget = const SizedBox(),
    this.hasActionButton = true, 
    this.actionCaption = 'Finalizar', 
    this.onAction,
  });
}
