import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/extensions/idt_dialog.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/detail/detail_effect.dart';
import 'package:bogota_app/pages/detail/detail_view_model.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'dart:math';

import '../../app_theme.dart';

class DetailPage extends StatelessWidget {
  static String namePage = 'detail_page';
  final bool isHotel;
  final DataPlacesDetailModel detail;

  DetailPage({this.isHotel = false, required this.detail});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          DetailViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return DetailWidget(isHotel, detail);
      },
    );
  }
}

class DetailWidget extends StatefulWidget {
  final bool _isHotel;
  final DataPlacesDetailModel _detail;

  DetailWidget(this._isHotel, this._detail);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  final _route = locator<IdtRoute>();
  bool isStart = true;
  bool isEnd = false;
  final scrollController = ScrollController();
  StreamSubscription<DetailEffect>? _effectSubscription;
  final randomFloatNumber = Random().nextDouble() * (5 - 2) + 2;

  @override
  void initState() {
    print('detail page');
    final viewModel = context.read<DetailViewModel>();
    viewModel.pushPlaceVisitedStorageLocal(widget._detail);

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is DetailControllerScrollEffect) {
        scrollController.animateTo(
            event.next
                ? scrollController.offset + event.width
                : scrollController.offset - event.width,
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: event.duration));
      } else if (event is ShowDialogAddSavedPlaceEffect) {
        context.showDialogObservation(
          titleDialog: ' Funcionalidad para usuarios registrados',
          bodyTextDialog:
              '* Te permite agregar este lugar a tu lista de Favoritos *\n\n¿Quieres iniciar sesion?',
          textPrimaryButton: 'Ir al Login...',
          textSecondButtom: 'Luego',
          actionPrimaryButtom: _route.goLogin,
        );
      }
    });

    // Verificación si es favorito o no, o que onda.
    viewModel.isFavorite(widget._detail.id).then((value) {
      viewModel.status = viewModel.status.copyWith(isFavorite: value);
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: viewModel.offMenuBack,
        child: Scaffold(
            bottomNavigationBar: IdtBottomAppBar(),
            extendBody: true,
            extendBodyBehindAppBar: true,
            floatingActionButton: IdtFab(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            backgroundColor: IdtColors.white,
            body: _buildDiscover(viewModel)),
      ),
    );
  }

  Widget _buildDiscover(DetailViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    print("widget._detail.url_audioguia_es");
    print(widget._detail.url_audioguia_es);
    double _newrating = 0;

    Widget _header() {
      return Stack(
        children: [
          Column(
            children: [
              Image.network(
                IdtConstants.url_image + widget._detail.image!,
                width: size.width,
                height: size.height * 0.5,
                fit: BoxFit.cover,
              )
            ],
          ),
          Positioned(
            // curva
            top: size.height * 0.301,
            left: 0,
            right: 0,
            child: SizedBox(
                child: SvgPicture.asset(IdtAssets.curve_up,
                    color: Colors.white, fit: BoxFit.fill)

                //Image(image: AssetImage(IdtAssets.curve_up), height: size.height * 0.9),
                ),
          ),
          Positioned(
            // rating Starts
            bottom: 120,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar(
                        // initialRating: 4.3,

                        itemSize: 30,
                        glowColor: IdtColors.orange,
                        initialRating: randomFloatNumber,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        ratingWidget: RatingWidget(
                          full: Icon(IdtIcons.star, color: IdtColors.amber),
                          half: Icon(IdtIcons.star_half_alt,
                              color: IdtColors.amber),
                          empty:
                              Icon(IdtIcons.star_empty, color: IdtColors.amber),
                        ),
                        onRatingUpdate: (rating) {
                          _newrating = rating;
                          print(rating);
                          print(_newrating);
                        },
                      ),
                      Text(
                        widget._detail.rate == '' || widget._detail.rate == '0'
                            // ? widget._detail.rate! + '/5'
                            ? randomFloatNumber.toStringAsFixed(1) + '/5'
                            : _newrating.toString(),
                        style: textTheme.textWhiteShadow.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    widget._detail.title!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.textWhiteShadow.copyWith(fontSize: 22),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            // app_bar row
            top: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 1 / 2,
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: SvgPicture.asset(
                      IdtAssets.back_white,
                      color: IdtColors.white,
                    ),
                    iconSize: 50,
                    onPressed: _route.pop,
                  ),
                ),
                Container(
                  width: size.width * 1 / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.share,
                            color: IdtColors.white,
                          ),
                          iconSize: 35,
                          onPressed: () {
                            print("Share");
                            Share.share(
                                "Visita la página oficial de turismo de Bogotá https://bogotadc.travel/");
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 15.0),
                        child: IconButton(
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            viewModel.status.isFavorite
                                ? IdtIcons.heart2
                                : Icons.favorite_border,
                            color: viewModel.status.isFavorite
                                ? IdtColors.red
                                : IdtColors.white,
                          ),
                          iconSize: 30,
                          onPressed: BoxDataSesion.isLoggedIn
                              ? () => viewModel.onTapFavorite(widget._detail.id)
                              : () {
                                  viewModel.dialogSuggestionLoginSavedPlace();
                                },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    Widget _footerImages(DetailViewModel viewModel) {
      return widget._detail.gallery!.length > 0
          ? Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: arrowValidation,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        //carrusel imagenes
                        margin: EdgeInsets.only(bottom: 0, top: 3),
                        width: size.width,
                        height: size.height * 0.5,
                        color: IdtColors.white,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget._detail.gallery!.length,
                          itemExtent: MediaQuery.of(context).size.width,
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
                          itemBuilder: (context, index) => Image.network(
                            IdtConstants.url_image +
                                widget._detail.gallery![index],
                            height: size.height * 0.5,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      isStart
                          ? SizedBox.shrink()
                          : Positioned(
                              //flecha Izquierda
                              bottom: size.height * 1 / 6,
                              left: 0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Transform.rotate(
                                  angle: 3.1416,
                                  child: IconButton(
                                    iconSize: 45,
                                    alignment: Alignment.centerLeft,
                                    icon: Icon(
                                      Icons.play_circle_fill,
                                      color: IdtColors.white,
                                    ),
                                    onPressed: () =>
                                        viewModel.onChangeScrollController(
                                            1000, false, size.width),
                                  ),
                                ),
                              ),
                            ),
                      isEnd
                          ? SizedBox.shrink()
                          : Positioned(
                              //flecha derecha
                              right: 0,
                              bottom: size.height * 1 / 6,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: IconButton(
                                  iconSize: 45,
                                  alignment: Alignment.centerRight,
                                  icon: Icon(
                                    Icons.play_circle_fill,
                                    color: IdtColors.white,
                                  ),
                                  onPressed: () =>
                                      viewModel.onChangeScrollController(
                                          1000, true, size.width),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Positioned(
                    //Curva de abajo
                    bottom: size.height * 0.32,
                    right: 0,
                    left: 0,
                    child: FittedBox(
                        alignment: Alignment.topCenter,
                        child:
/*                  Image(image: AssetImage(IdtAssets.curve_down),
                      height: size.height * 0.92
                  ),*/
                            SvgPicture.asset(IdtAssets.curve_down,
                                color: Colors.white, fit: BoxFit.fill))),
              ],
            )
          : SizedBox.shrink();
    }

    Widget _btnsPlaces(DataPlacesDetailModel _detail) {
      return Row(
        // row botonoes ubicacion y audio
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          viewModel.validationEmptyResponse(widget._detail.location)
              ? Column(
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: IdtColors.orange, width: 1),
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 100.0, maxHeight: 55),
                        decoration: StylesMethodsApp().decorarStyle(
                            IdtGradients.orange,
                            30,
                            Alignment.bottomRight,
                            Alignment.topLeft),
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            IdtIcons.mappin,
                            color: IdtColors.white,
                            size: 40,
                          ),
                          onPressed: () =>
                              viewModel.launchMap(widget._detail.location!),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    AutoSizeText('Como llegar',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        maxFontSize: 13,
                        minFontSize: 10,
                        style: textTheme.textDetail)
                  ],
                )
              : SizedBox.shrink(),
          SizedBox(
            width: 10,
          ),
        ],
      );
    }

    Widget _btnGradient(
      String dataText, {
      required onPress,
      required IconData icon,
      required Color color,
      required List<Color> listColors,
    }) {
      //Columna de botonoes para los hoteles
      return RaisedButton(
        onPressed: onPress,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: color, width: 1),
            borderRadius: BorderRadius.circular(17.0)),
        padding: EdgeInsets.all(0),
        child: Container(
            width: size.width * 0.7,
            decoration: StylesMethodsApp().decorarStyle(
                listColors, 17, Alignment.bottomCenter, Alignment.topCenter),
            padding: EdgeInsets.symmetric(vertical: 7),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(
                    icon,
                    color: IdtColors.white,
                    size: 30,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    dataText,
                    style: textTheme.textButtomWhite,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
      );
    }

    Widget _btnsHotel() {
      //Column botones en hoteles
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _btnGradient(widget._detail.address.toString(),
              onPress: () => viewModel.launchMap(widget._detail.location!),
              icon: IdtIcons.mappin,
              color: IdtColors.orange,
              listColors: IdtGradients.orange),
          SizedBox(
            height: 5,
          ),
          _btnGradient(widget._detail.phone.toString(),
              onPress: () => viewModel.launchCall(widget._detail.phone!),
              icon: Icons.phone,
              color: IdtColors.green,
              listColors: IdtGradients.green),
          SizedBox(
            height: 5,
          ),
          _btnGradient('Visitar sitio web',
              onPress: () => viewModel.launchPageWeb(widget._detail.webUrl!),
              icon: Icons.wifi_tethering_sharp,
              color: IdtColors.blueDark,
              listColors: IdtGradients.blueDark),
          SizedBox(
            height: 10,
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Container(
          color: IdtColors.white,
          child: Column(
            children: [
              _header(),
              SizedBox(
                height: 0,
              ),
              widget._isHotel ? _btnsHotel() : _btnsPlaces(widget._detail),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        margin: EdgeInsets.only(bottom: 15),
                        child: _hasDescription(viewModel)
                            ? Text(
                                removeAllHtmlTags(widget._detail.description ??
                                    widget._detail.body ??
                                    ''),
                                style: textTheme.textDescrip,
                                maxLines: viewModel.status.moreText ? null : 20,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.justify,
                              )
                            : Text(
                                'En el momento no tenemos una descripción para este lugar.',
                                style: textTheme.textDetail,
                                maxLines: viewModel.status.moreText ? null : 20,
                                textAlign: TextAlign.center,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: ClipRect(
                            // <-- clips to the 200x200 [Container] below
                            child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 0.2,
                            sigmaY: 0.2,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            color: IdtColors.white.withOpacity(
                                viewModel.status.moreText ? 0 : 0.5),
                          ),
                        )),
                      )
                    ],
                  ),
                  _hasDescription(viewModel)
                      ? TextButton(
                          child: Text(
                              viewModel.status.moreText
                                  ? 'MOSTRAR MENOS'
                                  : 'SEGUIR LEYENDO',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.blueDetail.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          onPressed: viewModel.readMore,
                        )
                      : SizedBox.shrink()
                ],
              ),
              SizedBox(
                height: 5,
              ),
              _footerImages(viewModel),
              _hasDescription(viewModel)
                  ? SizedBox(
                      height: 80,
                    )
                  : SizedBox.shrink()
            ],
          )),
    );
  }

  bool _hasDescription(DetailViewModel viewModel) {
    return viewModel.validationEmptyResponse(widget._detail.description) ||
        viewModel.validationEmptyResponse(widget._detail.body);
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  bool arrowValidation(ScrollNotification scroll) {
    if (scroll is ScrollNotification) {
      if (scrollController.position.atEdge) {
        setState(() {
          final isEnd = scrollController.position.pixels != 0;
          this.isStart = !isEnd;
          this.isEnd = isEnd;
        });
      } else
        setState(() {
          isStart = false;
          isEnd = false;
        });
    }
    return true;
  }
}
