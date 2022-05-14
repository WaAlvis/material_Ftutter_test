part of 'info_view.dart';

class _InfoMobile extends StatelessWidget {
  const _InfoMobile({Key? key, required this.arguments}) : super(key: key);

  final InfoViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: arguments.pageTitle == null || arguments.pageTitle!.isEmpty
          ? null
          : LdAppbar(
              withBackIcon: true,
              title: arguments.pageTitle,
              centerTitle: false,
            ),
      extendBodyBehindAppBar: true,
      body: AppbarCircles(
        hAppbar: 0,
        content: Container(
          width: size.width,
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (arguments.pageTitle == null || arguments.pageTitle!.isEmpty)
                Container()
              else
                ...divider(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: content(arguments, textTheme, size),
                ),
              ),
              if (arguments.hasActionButton)
                PrimaryButtonCustom(
                  arguments.actionCaption,
                  onPressed: arguments.onAction,
                )
              else
                Container(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> divider() => <Widget>[
      const SizedBox(
        height: 70,
      ),
      Container(
        width: 100,
        height: 5,
        decoration: const BoxDecoration(
          color: LdColors.orangePrimary,
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
      ),
    ];

List<Widget> content(
        InfoViewArguments arguments, TextTheme textTheme, Size size) =>
    <Widget>[
      SvgPicture.asset(imageList[arguments.imageType.index]),
      const SizedBox(height: 20),
      Text(
        arguments.title!,
        style: textTheme.infoTitle
            .copyWith(color: arguments.colorTitle, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: size.width * .8,
        child: Text(
          arguments.description,
          style: textTheme.textWhite.copyWith(fontWeight: FontWeight.normal),
          textAlign: TextAlign.center,
        ),
      ),
      arguments.customWidget,
      Container(),
    ];
