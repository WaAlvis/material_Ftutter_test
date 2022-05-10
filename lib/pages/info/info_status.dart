import 'package:localdaily/view_model.dart';

class InfoViewStatus extends ViewStatus {
  final bool isLoading;

  InfoViewStatus({
    required this.isLoading,
  });

  InfoViewStatus copyWith({
    bool? isLoading,
  }) {
    return InfoViewStatus(isLoading: isLoading ?? this.isLoading);
  }
}
