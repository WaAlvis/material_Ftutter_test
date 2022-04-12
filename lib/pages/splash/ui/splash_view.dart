import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/splash/splash_view_model.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:provider/provider.dart';

part 'splash_mobile.dart';

part 'splash_web.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<SplashViewModel>(
      create: (_) => SplashViewModel(),
      builder: (BuildContext context, _) {
        return const _SplashBody();
      },
    );
  }
}

class _SplashBody extends StatefulWidget {
  const _SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<_SplashBody> {
  @override
  void initState() {
    final SplashViewModel viewModel = context.read<SplashViewModel>();
    final ConfigurationProvider configurationProvider =
        context.read<ConfigurationProvider>();

    viewModel.onInit(context, configurationProvider);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: maxWidth > 1024
                  ? const _SplashWeb()
                  : _SplashMobile(
                      constraints: constraints,
                    ),
            )
          ],
        );
      },
    );
  }
}
