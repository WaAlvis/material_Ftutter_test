part of 'ui/filters_view.dart';

class FiltersArguments {
  final Function? setFilters;
  final Function? getFilters;
  final HomeStatus? homeStatus;
  late ExtraFilters? extraFilters;
  late int? indexTab;

  FiltersArguments({
    this.extraFilters,
    this.getFilters,
    this.homeStatus,
    this.setFilters,
    this.indexTab,
  });
}
