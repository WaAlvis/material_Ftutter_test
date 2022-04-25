import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/view_model.dart';

class HomeStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  final int indexTab;
  final bool hideWallet;
  final bool hideValues;
  late ResultHome offersBuyDataHome;
  late ResultHome offersSaleDataHome;
  late ResultHome operationBuyData;
  late ResultHome operationSaleData;
  late ResultHome myOfferBuyData;
  late ResultHome myOfferSaleData;
  late List<DataUserAdvertisement> listHistoryOpertaions;

  final TypeOffer typeOffer;
  final String image;
  final String titleText;
  final ResultDataUser? resultDataUser;

  // final String detailText;
  final String buttonText;
  final double balance;

  HomeStatus({
    this.resultDataUser,
    required this.offersBuyDataHome,
    required this.offersSaleDataHome,
    required this.operationBuyData,
    required this.operationSaleData,
    required this.myOfferBuyData,
    required this.myOfferSaleData,
    required this.listHistoryOpertaions,
    required this.hideWallet,
    required this.hideValues,
    required this.indexTab,
    this.isLoading = true,
    required this.isError,
    required this.typeOffer,
    required this.image,
    required this.titleText,
    // required this.detailText,
    required this.buttonText,
    required this.balance,
  });

  HomeStatus copyWith({
    ResultDataUser? resultDataUser,
    bool? isLoading,
    bool? isError,
    bool? hideWallet,
    bool? hideValues,
    ResultHome? offersSaleDataHome,
    ResultHome? offersBuyDataHome,
    ResultHome? operationBuyData,
    ResultHome? operationSaleData,
    ResultHome? myOfferBuyData,
    ResultHome? myOfferSaleData,
    int? indexTab,
    TypeOffer? typeOffer,
    String? image,
    String? titleText,
    List<DataUserAdvertisement>? listHistoryOpertaions,
    // String? detailText,
    String? buttonText,
    double? balance,
  }) {
    return HomeStatus(
      resultDataUser: resultDataUser ?? this.resultDataUser,
      hideWallet: hideWallet ?? this.hideWallet,
      hideValues: hideValues ?? this.hideValues,
      indexTab: indexTab ?? this.indexTab,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      offersBuyDataHome: offersBuyDataHome ?? this.offersBuyDataHome,
      offersSaleDataHome: offersSaleDataHome ?? this.offersSaleDataHome,
      operationBuyData: operationBuyData ?? this.operationBuyData,
      operationSaleData: operationSaleData ?? this.operationSaleData,
      myOfferBuyData: myOfferBuyData ?? this.myOfferBuyData,
      myOfferSaleData: myOfferSaleData ?? this.myOfferSaleData,
      typeOffer: typeOffer ?? this.typeOffer,
      image: image ?? this.image,
      listHistoryOpertaions:
          listHistoryOpertaions ?? this.listHistoryOpertaions,
      titleText: titleText ?? this.titleText,
      // detailText: detailText ?? this.detailText,
      buttonText: buttonText ?? this.buttonText,
      balance: balance ?? this.balance,
    );
  }
}
