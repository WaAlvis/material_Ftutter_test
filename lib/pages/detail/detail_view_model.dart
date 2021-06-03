import 'dart:io';

import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/detail/detail_effect.dart';
import 'package:bogota_app/pages/detail/detail_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailViewModel extends EffectsViewModel<DetailStatus, DetailEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;

  DetailViewModel(this._route, this._interactor) {
    status = DetailStatus(
      isLoading: true,
      isFavorite: false,
      moreText: false,
    );
  }

  void readMore() {
    final bool tapClick = status.moreText;
    status = status.copyWith(moreText: !tapClick);
  }

  void goPlayAudioPage(DataPlacesDetailModel _detail) {
    status = status.copyWith(isLoading: true);
    _route.goPlayAudio(detail: _detail);
  }

  onTapFavorite(String idplace) async {
   late bool value = status.isFavorite;
   print("idplace");
   print(idplace);
    final favoriteResponse = await _interactor.postFavorite(idplace);
    if (favoriteResponse is IdtSuccess<FavoriteModel?>) {
      print("model detail");
      print(favoriteResponse.body!.message);
     // _route.goDetail(isHotel: false, detail: placebyidResponse.body!);
      /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } /* else {
      final erroRes = placebyidResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }*/
    status = status.copyWith(isLoading: false);

    status = status.copyWith(isFavorite: !value);
    print("boll value favorite");
    print(status.isFavorite);
  }

  void onChangeScrollController(bool value, double width) {
    addEffect(DetailControllerScrollEffect(300, width, value));
  }

  void launchCall(String phone) async {
    print('Llamando desde el Boton,');
    launch("tel: $phone");
    if (Platform.isIOS) print('Verificar si marca desde un dispositivo real');
  }

  Future<String> launchPageWeb(String urlPage) async {
    String newUrl = '';

    print('Abriendo pagina del Hotel, $urlPage');
    if (urlPage[0] == 'w') {
      launch('http://$urlPage');
      print('Sin protocolo');
      newUrl = urlPage;
      print(newUrl);
    } else {
      print('Con protocolo');
      launch(urlPage);
      newUrl = urlPage.substring(8);
      print(newUrl);
    }
    return newUrl;
  }

  void launchMap(String location) async {
    print('Abriendo Map');
    String latitude = location.split(", ").first;
    String longitude = location.split(", ").last;
    final double lat = double.parse(latitude);
    final double lon = double.parse(longitude);
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error al lanzar la url: $url';
    }
  }
}
