import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/splash/splash_status.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

class SplashViewModel extends ViewModel<SplashStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  SplashViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = SplashStatus(
      isLoading: false,
      isError: true,
    );
  }
}
