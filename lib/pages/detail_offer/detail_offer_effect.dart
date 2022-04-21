import 'package:flutter/material.dart';
import 'package:localdaily/view_model.dart';

abstract class DetailOfferEffect extends Effect {}

class ValidateOfferEffect extends DetailOfferEffect {}

class ConfirmOfferEffect extends DetailOfferEffect {
  final VoidCallback action;
  ConfirmOfferEffect(this.action);
}

class ShowSnackbarConnectivityEffect extends DetailOfferEffect {
  final String message;
  ShowSnackbarConnectivityEffect(this.message);
}

class ShowSnackbarSuccesEffect extends DetailOfferEffect {
  ShowSnackbarSuccesEffect();
}

class ShowSnackbarErrorEffect extends DetailOfferEffect {
  final String message;
  ShowSnackbarErrorEffect(this.message);
}
