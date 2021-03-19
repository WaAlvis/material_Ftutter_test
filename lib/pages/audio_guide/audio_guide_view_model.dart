import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_status.dart';
import 'package:bogota_app/view_model.dart';

class AudioGuideViewModel extends ViewModel<AudioGuideStatus> {

  final IdtRoute _route;
  final PlaceRepository _interactor;

  AudioGuideViewModel(this._route, this._interactor) {
    status = AudioGuideStatus(
      isLoading: true,
      openMenu: false
    );
  }

  void onInit() async {
    //TODO
  }

  void onpenMenu() {
    status = status.copyWith(openMenu: true);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  void goDetailPage() {
    _route.goDetail(isHotel: false);
  }
}
