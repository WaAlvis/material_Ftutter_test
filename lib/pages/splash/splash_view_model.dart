import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/splash/splash_status.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/modules/configuration_module.dart';
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

  Future<void> onInit(
    BuildContext context,
    ConfigurationProvider configurationProvider,
  ) async {
    await ConfigurationModule.getTypeOffer(configurationProvider, _interactor);
    await ConfigurationModule.getBanks(configurationProvider, _interactor);
    await ConfigurationModule.getDocumentType(
      configurationProvider,
      _interactor,
    );
    await ConfigurationModule.getAccountTypes(
      configurationProvider,
      _interactor,
    );
    ConfigurationModule.getSupportStatus(configurationProvider, _interactor);
    ConfigurationModule.getSupportType(configurationProvider, _interactor);

    if (configurationProvider.getResultBanks != null &&
        configurationProvider.getResultDocsTypes != null &&
        configurationProvider.getResultTypeOffer != null) {
      _route.goHome(context);
    }
  }
}
