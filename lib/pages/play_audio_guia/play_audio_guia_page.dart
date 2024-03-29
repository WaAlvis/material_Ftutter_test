import 'dart:async';
import 'dart:ui';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/mock/data/testData.dart';
import 'package:bogota_app/pages/play_audio/play_audio_effect.dart';
import 'package:bogota_app/pages/play_audio/play_audio_page.dart';

import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/audio_payer/player_buttons.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import 'play_audio_guia_view_model.dart';

class PlayAudioGuiaPage extends StatelessWidget {
  final DataPlacesDetailModel detail;

  PlayAudioGuiaPage({required this.detail});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayAudioGuiaViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return PlayAudioGuiaWidget(detail);
      },
    );
  }
}

class PlayAudioGuiaWidget extends StatefulWidget {
  final DataPlacesDetailModel _detail;

  PlayAudioGuiaWidget(this._detail);

  double sizeContainer = 0;

  @override
  _PlayAudioGuiaWidgetState createState() => _PlayAudioGuiaWidgetState();
}

class _PlayAudioGuiaWidgetState extends State<PlayAudioGuiaWidget>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  final testdata = testData(); //instacia para acceder al data Mock
  bool offlineMode = true;
  final _route = locator<IdtRoute>();
  final List<String> _dropdownValues = ['Español', 'Ingles', 'Portugües'];
  late AudioPlayer _player; //TODO Audio Anterior Refactor
  bool firstValidate = false;
  StreamSubscription<PlayAudioGuiaEffect>? _effectSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Hardcoded audio sources
    // TODO: Get sources with a network call, or at least move to a separated file.
    _audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: testdata.ListURIexample, //Lista de Datos Mock AUDIO
      ),
    )
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose() {
    _player.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PlayAudioGuiaViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: IdtBottomAppBar(),
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButton: IdtFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: IdtColors.white,
        body: _buildPlayAudio(viewModel),
      ),
    );
  }

  Widget _buildPlayAudio(PlayAudioGuiaViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;

    Widget _body() {
      final List dummyList = List.generate(10, (index) {
        return {
          "id": index,
          "title": "This is the title $index",
          "subtitle": "This is the subtitle $index"
        };});
      return Container(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                child: Text(
                  widget._detail.title!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.textWhiteShadow.copyWith(fontSize: 25),
                ),
              ),
              Text(
                '18 Pistas de audio',
                style:
                    textTheme.textWhiteShadow.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '34:55 minutos ',
                style:
                    textTheme.textWhiteShadow.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                  icon: Icon(
                    viewModel.status.isFavorite ? IdtIcons.heart2 : Icons.favorite_border,
                    color: viewModel.status.isFavorite ? IdtColors.red : IdtColors.white,
                  ),
                  padding: EdgeInsets.only(right: 20.0),
                  iconSize: 35,
                  onPressed: BoxDataSesion.isLoggedIn
                      ? viewModel.onTapFavorite
                      : () {
                          viewModel.dialogSuggestionLoginSavedPlace();
                        }),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  IdtConstants.url_image + widget._detail.image!,
                  fit: BoxFit.cover,
                  height: sizeScreen.width * 0.5,
                  width: sizeScreen.width * 0.5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 12),
              FlutterSwitch(
                // value: viewModel.status.modeOffline,
                value: offlineMode,
                activeColor: IdtColors.blueAccent,
                activeToggleColor: IdtColors.white,
                inactiveColor: IdtColors.white,
                inactiveToggleColor: IdtColors.grayBtn,
                padding: 3,
                height: 30,
                onToggle: (bool value) {
                  setState(() {
                    offlineMode = value;
                  });
                },
              ),
              SizedBox(height: 8),
              Text(
                'Modo Offline',
                style: textTheme.textButtomWhite,
              ),
              PlayerButtons(_audioPlayer),
              Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 35, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget._detail.title!,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //TODO progreso de la reproduccion color
                      LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                        if (MediaQuery.of(context).size.width < 390) {
                          widget.sizeContainer = MediaQuery.of(context).size.width / 2;
                        } else {
                          widget.sizeContainer = MediaQuery.of(context).size.width / 1.65;
                        }
                        return Stack(
                          children: [
                            ImageAnimatedContainer(
                                width: widget.sizeContainer, imagePath: IdtAssets.waves),
                            StreamBuilder<Duration>(
                                stream: _audioPlayer.positionStream,
                                builder: (context, snapshot) {
                                  format(Duration? d) => d?.toString().substring(2, 7) ?? " ";
                                  final currentPosition = snapshot.data?.inSeconds ?? 0;
                                  final totalDuration = _audioPlayer.duration?.inSeconds ?? 1;
                                  final timeCurrent = format(snapshot.data);
                                  final totalTime = format(_audioPlayer.duration);
                                  final progresAudio = currentPosition / totalDuration; //es un %
                                  final widthAudio =
                                      widget.sizeContainer * (currentPosition / totalDuration);
                                  return IntrinsicWidth(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            ImageAnimatedContainer(
                                                width: widthAudio, imagePath: IdtAssets.waves_front),
                                            Container(
                                              width: widget.sizeContainer,
                                              child: SliderTheme(
                                                data: SliderTheme.of(context).copyWith(
                                                  trackShape: CustomSliderTrackShape(),
                                                  trackHeight: 0.0,
                                                  thumbShape: RoundSliderThumbShape(
                                                    enabledThumbRadius: 0,
                                                  ),
                                                  overlayShape:
                                                      RoundSliderOverlayShape(overlayRadius: 20.0),
                                                ),
                                                child: Slider(
                                                    min: 0.0,
                                                    max: totalDuration.toDouble(),
                                                    value: currentPosition.toDouble(),
                                                    onChanged: (pos) {
                                                      _audioPlayer
                                                          .seek(Duration(seconds: pos.toInt()));
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Text(
                                              timeCurrent,
                                              style: TextStyle(color: IdtColors.white, fontSize: 10),
                                            ),
                                            Spacer(),
                                            Text(totalTime,
                                                style: TextStyle(color: IdtColors.white, fontSize: 10)),
                                            SizedBox(width: 10,)
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        );
                      }),
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              // ListView.builder(
              //   itemCount: dummyList.length,
              //   itemBuilder: (context, index) => Card(
              //     elevation: 6,
              //     margin: EdgeInsets.all(10),
              //     child: ListTile(
              //       leading: CircleAvatar(
              //         child: Text(dummyList[index]["id"].toString()),
              //         backgroundColor: Colors.purple,
              //       ),
              //       title: Text(dummyList[index]["title"]),
              //       subtitle: Text(dummyList[index]["subtitle"]),
              //       trailing: Icon(Icons.add_a_photo),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          height: sizeScreen.height,
          width: sizeScreen.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(IdtConstants.url_image + widget._detail.image!),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        Positioned(
          // row superior
          top: 50,
          right: 0,
          left: 0,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      IdtAssets.back,
                      color: IdtColors.black.withOpacity(0.9),
                    ),
                    iconSize: 52,
                    padding: EdgeInsets.only(left: 10, bottom: 4),
                    alignment: Alignment.bottomCenter,
                    onPressed: _route.pop,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: IdtColors.white,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      color: IdtColors.black.withOpacity(0.6),
                      shape: BoxShape.rectangle,
                    ),
                    child: DropdownButton(
                      items: _dropdownValues
                          .map((value) => DropdownMenuItem(
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: textTheme.textButtomWhite,
                                ),
                                value: value,
                              ))
                          .toList(),
                      isExpanded: false,
                      iconSize: 30,
                      value: viewModel.status.language,
                      iconEnabledColor: Colors.white,
                      dropdownColor: IdtColors.black.withOpacity(0.4),
                      style: textTheme.titleGray,
                      hint: Text('Español'),
                      onChanged: viewModel.selectLanguage,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        ListView(
          children: [
            SizedBox(
              height: 120,
            ),
            _body(),
            SizedBox(
              height: 55,
            ),
            Container(
              color: IdtColors.red,
              height: 10,
              width: 10,
            )
          ],
        )
      ],
    );
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
