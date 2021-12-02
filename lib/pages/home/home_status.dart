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

  HomeStatus({
    required this.sellersDataHome,
    required this.hideWallet,
    required this.hideValues,
    required this.buyersDataHome,
    required this.indexTab,
    required this.isLoading,
    required this.isError,
  });

  HomeStatus copyWith({
    bool? isLoading,
    bool? isError,
    bool? hideWallet,
    bool? hideValues,
    ResultHome? sellersDataHome,
    int? indexTab,
    ResultHome? buyersDataHome,
  }) {
    return HomeStatus(
      hideWallet: hideWallet ?? this.hideWallet,
      hideValues: hideValues ?? this.hideValues,
      indexTab: indexTab ?? this.indexTab,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      sellersDataHome: sellersDataHome ?? this.sellersDataHome,
      buyersDataHome: buyersDataHome ?? this.buyersDataHome,
    );
  }
}
