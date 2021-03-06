import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/pages/search/search_effect.dart';
import 'package:bogota_app/pages/search/search_status.dart';
import 'package:bogota_app/utils/errors/search_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/view_model.dart';

class SearchViewModel extends EffectsViewModel<SearchStatus, SearchEffect> {
  final IdtRoute _route;
  final ApiInteractor _interactor;
  late String languageUser;

  SearchViewModel(this._route, this._interactor) {
    status = SearchStatus(
      isLoading: true,
      openMenu: false,
    );
  }

  void onInit() async {
    status = status.copyWith(
      isLoading: true,
    );
  }

  void goResultSearchPage(String keyWord) async {
    languageUser = BoxDataSesion.getLaguageByUser(); //get language User Prefered

    final Map query = {'keyword': keyWord};
    status = status.copyWith(isLoading: true);

    final responseSearch =
        await _interactor.getSearchResultList(query, languageUser);

    if (responseSearch is IdtSuccess<List<DataModel>?>) {
      final results = responseSearch.body!;

      if (results.isEmpty) {
        addEffect(ShowDialogEffect());
      } else {
        _route.goResultSearch(results, keyWord);
      }
    } else {
      final erroRes = responseSearch as IdtFailure<SearchError>;
      print(erroRes.message);
      UnimplementedError();
      //Todo implementar errores
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  Future<bool> offMenuBack() async {
    bool? shouldPop = true;

    if (status.openMenu) {
      status = status.copyWith(openMenu: false);
      return !shouldPop;
    } else {
      IdtRoute.route = HomePage.namePage;
      return shouldPop;
    }
  }
}
