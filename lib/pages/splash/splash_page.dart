import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/splash/splash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>(),
      ),
      builder: (context, _) {
        return SplashWidget();
      },
    );
  }
}

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => new _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
    final viewModel = context.read<SplashViewModel>();
    viewModel.onInit();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    _controller.forward();
    final viewModel = context.watch<SplashViewModel>();

    return Scaffold(
        backgroundColor: Color(0xff2164ac),
        body: Stack(
          children: [
            viewModel.status.imgSplash != null
                ? FadeTransition(
              opacity: _animation,
                  child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(viewModel.status.imgSplash!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                )
                : SizedBox.shrink(),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Container(
                  height: 65,
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IdtAssets.logo_bogota),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
