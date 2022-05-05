part of 'ui/filters_view.dart';

class FiltersArguments {
  final Function? setFilters;
  final Function? getFilters;
  final HomeStatus? homeStatus;
  final ExtraFilters? extraFilters;

  const FiltersArguments({
    this.extraFilters,
    this.getFilters,
    this.homeStatus,
    this.setFilters,
  });
}
