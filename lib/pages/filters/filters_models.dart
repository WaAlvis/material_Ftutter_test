part of 'ui/filters_view.dart';

class FiltersArguments {
  final Function? setFilters;
  final Function? getFilters;
  final Function? clearFilters;
  final HomeStatus? homeStatus;
  late ExtraFilters? extraFilters;
  late int? indexTab;

  FiltersArguments({
    this.extraFilters,
    this.homeStatus,
    this.setFilters,
    this.getFilters,
    this.clearFilters,
    this.indexTab,
  });

  FiltersArguments copyWith({
    Function? setFilters,
    Function? getFilters,
    Function? clearFilters,
    ExtraFilters? extraFilters,
    HomeStatus? homeStatus,
    int? indexTab,
  }) {
    return FiltersArguments(
        extraFilters: extraFilters ?? this.extraFilters,
        setFilters: setFilters ?? this.setFilters,
        getFilters: getFilters ?? this.getFilters,
        clearFilters: clearFilters ?? this.clearFilters,
        homeStatus: homeStatus ?? this.homeStatus,
        indexTab: indexTab ?? this.indexTab);
  }
}
