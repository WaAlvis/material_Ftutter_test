import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/filters/ui/filters_view.dart';
import 'package:localdaily/services/models/home/extra_filters.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/view_model.dart';

class HomeStatus extends ViewStatus {
  final bool isError;
  final bool isLoading;
  final bool isLoadingScroll;
  final bool thereIsMoreData;
  final OptionTab optionTab;
  final bool hideWallet;
  final bool hideValues;
  late ResultHome offersBuyDataHome;
  late ResultHome offersSaleDataHome;
  late ResultHome operationBuyData;
  late ResultHome operationSaleData;
  late ResultHome myOfferBuyData;
  late ResultHome myOfferSaleData;
  final TypeOffer typeOffer;
  final String image;
  final String titleText;
  final ResultDataUser? resultDataUser;

  // final String detailText;
  final String buttonText;
  final double balance;
  final int countNotification;

  //filters
  final ExtraFilters? extraFilters;
  final FiltersArguments? filtersArguments;
  final String? extraFiltersString;

  HomeStatus({
    this.resultDataUser,
    required this.offersBuyDataHome,
    required this.offersSaleDataHome,
    required this.operationBuyData,
    required this.operationSaleData,
    required this.myOfferBuyData,
    required this.myOfferSaleData,
    // required this.listHistoryOpertaions,
    required this.hideWallet,
    required this.hideValues,
    required this.optionTab,
    this.isLoading = true,
    this.isLoadingScroll = false,
    this.thereIsMoreData = true,
    required this.isError,
    required this.typeOffer,
    required this.image,
    required this.titleText,
    // required this.detailText,
    required this.buttonText,
    required this.balance,
    required this.countNotification,
    this.extraFilters,
    this.filtersArguments,
    this.extraFiltersString,
  });

  HomeStatus copyWith({
    ResultDataUser? resultDataUser,
    bool? isLoading,
    bool? isLoadingScroll,
    bool? thereIsMoreData,
    bool? isError,
    bool? hideWallet,
    bool? hideValues,
    ResultHome? offersSaleDataHome,
    ResultHome? offersBuyDataHome,
    ResultHome? operationBuyData,
    ResultHome? operationSaleData,
    ResultHome? myOfferBuyData,
    ResultHome? myOfferSaleData,
    OptionTab? optionTab,
    TypeOffer? typeOffer,
    String? image,
    String? titleText,
    // List<DataUserAdvertisement>? listHistoryOpertaions,
    // String? detailText,
    String? buttonText,
    double? balance,
    int? countNotification,
    ExtraFilters? extraFilters,
    FiltersArguments? filtersArguments,
    String? extraFiltersString,
  }) {
    return HomeStatus(
      resultDataUser: resultDataUser ?? this.resultDataUser,
      hideWallet: hideWallet ?? this.hideWallet,
      hideValues: hideValues ?? this.hideValues,
      optionTab: optionTab ?? this.optionTab,
      isLoading: isLoading ?? this.isLoading,
      thereIsMoreData: thereIsMoreData ?? this.thereIsMoreData,
      isLoadingScroll: isLoadingScroll ?? this.isLoadingScroll,
      isError: isError ?? this.isError,
      offersBuyDataHome: offersBuyDataHome ?? this.offersBuyDataHome,
      offersSaleDataHome: offersSaleDataHome ?? this.offersSaleDataHome,
      operationBuyData: operationBuyData ?? this.operationBuyData,
      operationSaleData: operationSaleData ?? this.operationSaleData,
      myOfferBuyData: myOfferBuyData ?? this.myOfferBuyData,
      myOfferSaleData: myOfferSaleData ?? this.myOfferSaleData,
      typeOffer: typeOffer ?? this.typeOffer,   
      image: image ?? this.image,
      // listHistoryOpertaions:
      //     listHistoryOpertaions ?? this.listHistoryOpertaions,
      titleText: titleText ?? this.titleText,
      // detailText: detailText ?? this.detailText,
      buttonText: buttonText ?? this.buttonText,
      balance: balance ?? this.balance,
      countNotification: countNotification ?? this.countNotification,
      extraFilters: extraFilters ?? this.extraFilters,
      filtersArguments: filtersArguments ?? this.filtersArguments,
      extraFiltersString: extraFiltersString ?? this.extraFiltersString,
    );
  }
}
