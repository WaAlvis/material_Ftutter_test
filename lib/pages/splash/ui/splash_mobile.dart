part of 'splash_view.dart';

class _SplashMobile extends StatelessWidget {
  const _SplashMobile({Key? key, required this.constraints}) : super(key: key);
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: BoxConstraints(minHeight: constraints.maxHeight),
      color: LdColors.blackBackground,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          const CircleDecoration(quarter: 2, color: LdColors.grayLight),
          const CircleDecoration(quarter: 4, color: LdColors.grayLight),
          const CircleDecoration(quarter: 6, color: LdColors.grayLight),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                SvgPicture.asset(LdAssets.logoWhiteOrange),
                const SizedBox(height: 50),
                const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(LdColors.orangePrimary),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    'Cargando configuraciones...',
                    style: textTheme.textWhite,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
