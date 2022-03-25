import 'package:flutter/material.dart';
import 'package:localdaily/view_model.dart';

abstract class DetailOfferBuyEffect extends Effect {}

class ValidateOfferEffect extends DetailOfferBuyEffect {}

class ShowSnackbarConnectivityEffect extends DetailOfferBuyEffect {
  final String message;

  ShowSnackbarConnectivityEffect(this.message);
}
