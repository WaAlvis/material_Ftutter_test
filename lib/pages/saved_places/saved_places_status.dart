import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/view_model.dart';

class SavedPlacesStatus extends ViewStatus{

  final bool isLoading;
  final bool openMenu;
  final List<bool> listSwitch;
  late List<DataAudioGuideModel> itemsSavedPlaces;


  SavedPlacesStatus({required this.isLoading, required this.openMenu, required this.listSwitch, required this.itemsSavedPlaces});

  SavedPlacesStatus copyWith({bool? isLoading, bool? openMenu, List<bool>? listSwitch, List<DataAudioGuideModel>? itemsSavedPlaces}) {
    return SavedPlacesStatus(
      isLoading: isLoading ?? this.isLoading,
      openMenu: openMenu ?? this.openMenu,
      listSwitch: listSwitch ?? this.listSwitch,
      itemsSavedPlaces: itemsSavedPlaces ??this.itemsSavedPlaces
    );
  }
}
