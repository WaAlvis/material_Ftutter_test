import 'package:localdaily/view_model.dart';

class HomeStatus extends ViewStatus{

  final bool isLoading;
  final bool isError;

  HomeStatus({required this.isLoading, required this.isError});

  HomeStatus copyWith({bool? isLoading, bool? isError}) {
    return HomeStatus(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
