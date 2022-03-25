import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/view_model.dart';

class HomeStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final int indexTab;
  final bool hideWallet;
  final bool hideValues;
  late ResultHome offersBuyDataHome;
  late ResultHome offersSaleDataHome;
  final TypeOffer typeOffer;
  final String image;
  final String titleText;

  // final String detailText;
  final String buttonText;

  HomeStatus({
    required this.offersBuyDataHome,
    required this.hideWallet,
    required this.hideValues,
    required this.offersSaleDataHome,
    required this.indexTab,
    this.isLoading = true,
    required this.isError,
    required this.typeOffer,
    required this.image,
    required this.titleText,
    // required this.detailText,
    required this.buttonText,
  });

  HomeStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? hideWallet,
    bool? hideValues,
    ResultHome? sellersDataHome,
    int? indexTab,
    ResultHome? buyersDataHome,
    TypeOffer? typeOffer,
    String? image,
    String? titleText,
    // String? detailText,
    String? buttonText,
  }) {
    return HomeStatus(
      hideWallet: hideWallet ?? this.hideWallet,
      hideValues: hideValues ?? this.hideValues,
      indexTab: indexTab ?? this.indexTab,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      offersBuyDataHome: sellersDataHome ?? this.offersBuyDataHome,
      offersSaleDataHome: buyersDataHome ?? this.offersSaleDataHome,
      typeOffer: typeOffer ?? this.typeOffer,
      image: image ?? this.image,
      titleText: titleText ?? this.titleText,
      // detailText: detailText ?? this.detailText,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}
