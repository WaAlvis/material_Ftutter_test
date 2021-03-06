import 'package:bogota_app/view_model.dart';

abstract class PlayAudioGuiaEffect extends Effect {

}

class PlayAudioValueControllerScrollEffect extends PlayAudioGuiaEffect {
  final int duration;
  final bool next;

  PlayAudioValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogModeOffEffect extends PlayAudioGuiaEffect {
  ShowDialogModeOffEffect();
}

class ShowDialogAddSavedPlaceEffect extends PlayAudioGuiaEffect {
  ShowDialogAddSavedPlaceEffect();
}
