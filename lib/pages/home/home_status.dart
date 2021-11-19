import 'package:localdaily/services/models/home/reponse/result_home.dart';
import 'package:localdaily/view_model.dart';

class HomeStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  late ResultHome sellersDataHome;
  late ResultHome buyersDataHome;

  HomeStatus(
      {required this.sellersDataHome,
      required this.buyersDataHome,
      required this.isLoading,
      required this.isError});

  HomeStatus copyWith(
      {bool? isLoading,
      bool? isError,
      ResultHome? sellersDataHome,
      ResultHome? buyersDataHome}) {
    return HomeStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      sellersDataHome: sellersDataHome ?? this.sellersDataHome,
      buyersDataHome: buyersDataHome ?? this.buyersDataHome,
    );
  }
}
