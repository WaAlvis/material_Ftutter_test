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

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<SplashViewModel>();
    viewModel.getSplash();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    final viewModel = context.watch<SplashViewModel>();

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(IdtAssets.splash),
              fit: BoxFit.cover,
            ),
          ),
        ),
        viewModel.status.imgSplash != null
            ? AnimatedSwitcher(
                duration: Duration(seconds: 3),
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
                colors: [Color.fromARGB(0, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
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
        Positioned(
          left: 20,
            right: 20,
            top: sizeScreen.height * 0.72,
            child:           SizedBox(
              //tercera animacion
              width: sizeScreen.width,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FadeAnimatedText('1. do IT!'),
                    FadeAnimatedText('1. do it RIGHT!!'),
                    FadeAnimatedText('1. do it RIGHT NOW!!!'),
                  ],
                ),
              ),
            )),
        Positioned(
          top: sizeScreen.height * 0.75,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 20.0, height: 100.0),
              const Text(
                '2. Be',
                style: TextStyle(fontSize: 23.0, color: Colors.white),
              ),
              const SizedBox(width: 20.0, height: 100.0),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Horizon',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                  RotateAnimatedText('AWESOME'),
                  RotateAnimatedText('OPTIMISTIC'),
                  RotateAnimatedText('DIFFERENT'),
                ]),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: sizeScreen.height * 0.86,
          child: AnimatedTextKit(
            //Segunda Animacion

            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText(
                "3. This is the moment to do it...",
                textStyle: Theme.of(context).textTheme.titleWhite.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black54, offset: Offset(10, 5), blurRadius: 5)]),
                speed: const Duration(milliseconds: 200),
              ),
            ],
            totalRepeatCount: 1,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
        Positioned(
          top: sizeScreen.height * 0.92,
          left: 20,
          right: 20,
          child:
          Text("4. This is the moment to do it...",
              style: const TextStyle(
                fontSize: 25.0,
                fontFamily: 'Horizon',
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ))
        )
      ],
    ));
  }
}
