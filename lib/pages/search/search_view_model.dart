import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/search/search_status.dart';
import 'package:bogota_app/utils/errors/eat_error.dart';
import 'package:bogota_app/utils/errors/search_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class SearchViewModel extends ViewModel<SearchStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  SearchViewModel(this._route, this._interactor) {
    status = SearchStatus(
      isLoading: true,
      openMenu: false,
      itemsResultSearch: [],

    );
  }

  void onInit(List<DataModel> results) async {
    status = status.copyWith(isLoading: true, itemsResultSearch: results);

    //TODO
  }

  void goResultSearchPage(
      // List<DataModel> results,
      ) async {
    // final Map query = {status.: item.id};
    status = status.copyWith(isLoading: true);

    final responseSearch = await _interactor.getSearchResultList({'keyword':'iglesia'});

    if (responseSearch is IdtSuccess<List<DataModel>?>) {
      final results = responseSearch.body!;
      print(results);
      _route.goResultSearch(results: results);


      // status.places.addAll(UnmissableResponse.body)
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

}
