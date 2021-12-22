import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/result_home.dart';
import 'package:localdaily/view_model.dart';

class HomeStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final int indexTab;
  final bool hideWallet;
  final bool hideValues;
  late ResultHome sellersDataHome;
  late ResultHome buyersDataHome;
  final TypeOffert typeOffert;
  final String image;
  final String titleText;
  // final String detailText;
  final String buttonText;

  HomeStatus({
    required this.sellersDataHome,
    required this.hideWallet,
    required this.hideValues,
    required this.buyersDataHome,
    required this.indexTab,
    required this.isLoading,
    required this.isError,
    required this.typeOffert,
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
    TypeOffert? typeOffert,
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
      sellersDataHome: sellersDataHome ?? this.sellersDataHome,
      buyersDataHome: buyersDataHome ?? this.buyersDataHome,
      typeOffert: typeOffert ?? this.typeOffert,
      image: image ?? this.image,
      titleText: titleText ?? this.titleText,
      // detailText: detailText ?? this.detailText,
      buttonText: buttonText?? this.buttonText,
    );
  }
}
