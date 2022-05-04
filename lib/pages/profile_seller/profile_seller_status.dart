import 'package:localdaily/services/models/info_user_publish/response/result_info_user_publish.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

class ProfileSellerStatus extends ViewStatus {
  final bool isLoading;
  final bool isError;
  late ResultInfoUserPublish? infoUserPublish;

  ProfileSellerStatus({
    required this.isLoading,
    required this.isError,
    this.infoUserPublish,
  });

  ProfileSellerStatus copyWith({
    ResultInfoUserPublish? infoUserPublish,
    bool? isLoading,
    bool? isError,
    bool? hidePass,
    bool? isEmailFieldEmpty,
    bool? isPswFieldEmpty,
  }) {
    return ProfileSellerStatus(
      infoUserPublish: infoUserPublish ?? this.infoUserPublish,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
