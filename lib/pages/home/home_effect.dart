import 'package:bogota_app/view_model.dart';

abstract class HomeEffect extends Effect {

}

class HomeValueControllerScrollEffect extends HomeEffect {
  final int duration;
  final bool next;

  HomeValueControllerScrollEffect(this.duration, this.next);
}

class ShowDialogSavedPlacedEffect extends HomeEffect {
  ShowDialogSavedPlacedEffect();
}

class ShowDialogSuggestionLoginEffect extends HomeEffect {
  ShowDialogSuggestionLoginEffect();
}
