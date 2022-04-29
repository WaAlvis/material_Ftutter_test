import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/notification/notification_status.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

class NotificationViewModel extends ViewModel<NotificationStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  NotificationViewModel(this._route, this._interactor) {
    status = NotificationStatus(isLoading: false, isError: false);
  }

  Future<void> onInit() async {}
}
