import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/contact_support/contact_support_status.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

class ContactSupportViewModel extends ViewModel<ContactSupportStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  late bool isbuy;

  ContactSupportViewModel(
    this._route,
    this._interactor, {
    required this.isbuy,
  }) {
    status = ContactSupportStatus(
      isLoading: false,
      isError: false,
      isBuy: isbuy,
      description: '',
      mobile: '',
    );
  }

  Future<void> onInit() async {}

  String? validatorNotEmpty(String? valueText) {
    if (valueText == null || valueText.isEmpty) {
      return '* Campo necesario';
    }
    return null;
  }

  void changeDescription(String description) => status = status.copyWith(
        description: description,
      );

  void changeMobile(String mobile) => status = status.copyWith(mobile: mobile);
}
