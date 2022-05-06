import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/filters/filters_view_model.dart';
import 'package:localdaily/pages/filters/ui/components/custom_round_range_slider_thumb.dart';
import 'package:localdaily/pages/home/home_status.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/home/extra_filters.dart';
import 'package:localdaily/services/models/home/extra_filters_string.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

part 'filters_web.dart';
part 'filters_mobile.dart';
part 'components/custom_slide.dart';
part '../filters_models.dart';

class FilterView extends StatelessWidget {
  const FilterView({
    Key? key,
    required this.filtersArguments,
  }) : super(key: key);
  final FiltersArguments filtersArguments;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<FilterViewModel>(
      create: (_) => FilterViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return _FilterBody(
          filtersArguments: filtersArguments,
        );
      },
    );
  }
}

class _FilterBody extends StatefulWidget {
  const _FilterBody({Key? key, required this.filtersArguments})
      : super(key: key);
  final FiltersArguments filtersArguments;

  @override
  State<_FilterBody> createState() => __FilterBodyState();
}

class __FilterBodyState extends State<_FilterBody> {
  @override
  void initState() {
    final FilterViewModel viewModel = context.read<FilterViewModel>();
    final ConfigurationProvider configurationProvider =
        context.read<ConfigurationProvider>();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => viewModel.onInit(context, configurationProvider),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FilterViewModel viewModel = context.watch<FilterViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : const SizedBox.shrink();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        return Stack(
          children: <Widget>[
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: maxWidth > 1024
                      ? const _FilterWeb()
                      : _FilterMobile(
                          filtersArguments: widget.filtersArguments),
                ),
              ],
            ),
            loading,
          ],
        );
      },
    );
  }
}
