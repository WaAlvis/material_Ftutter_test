import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/pages/activity/activity_view_model.dart';
import 'package:bogota_app/pages/profile/profile_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/menu_tap.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class ActivityPage extends StatelessWidget {
  static final String namePage = 'activity_page';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ActivityViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return ActivityWidget();
      },
    );
  }
}

class ActivityWidget extends StatefulWidget {
  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ActivityViewModel>().onInit();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivityViewModel>();
    return SafeArea(
      child: Scaffold(
          appBar: IdtAppBar(viewModel.openMenu),
          backgroundColor: IdtColors.white,
          extendBody: true,
          bottomNavigationBar:
              viewModel.status.openMenu ? null : IdtBottomAppBar(),
          floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: _buildDiscover(viewModel)),
    );
  }

  Widget _buildDiscover(ActivityViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final List<DataPlacesDetailModel> _places =
        viewModel.status.detail; //lugares para la grilla
    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();
    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: viewModel.status.openMenu
          ? IdtMenu(
              closeMenu: viewModel.closeMenu,
              optionIndex: '',
            )
          : SizedBox.shrink(),
    );

    final menuTap = viewModel.status.openMenuTab
        //fila de plan, producto, zona
        ? IdtMenuTap(
            closeMenu: viewModel.closeMenuTab,
            listItems: viewModel.status.listOptions,
            goFilters: (item) {})
        : SizedBox.shrink();

    Widget _buttonTap(
      String label,
      VoidCallback onTap,
      bool isSelected,
    ) {
      return Expanded(
        child: Column(
          children: [
            TextButton(
              child: Text(label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.subTitleBlack),
              onPressed: onTap,
            ),
            isSelected
                ? Container(
                    height: 5,
                    width: 50,
                    color: Colors.black,
                  )
                : SizedBox.shrink()
          ],
        ),
      );
    }

    Widget imagesCard(DataPlacesDetailModel item, int index, List listItems) =>
        (InkWell(
          onTap: () => viewModel.goDetailPage(item.id.toString()),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                    // Validacion para el borde superior izquiero
                    (index == 0)
                        ? BorderRadius.only(topLeft: Radius.circular(15))

                        // Validacion para el borde superior derecho
                        : (index == 2)
                            ? BorderRadius.only(topRight: Radius.circular(15))

                            // Validaciones para el borde inferior izquiero
                            : (index == (listItems.length - 3) &&
                                    index % 3 == 0)
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(15))
                                : (index == (listItems.length - 2) &&
                                        index % 3 == 0)
                                    ? BorderRadius.only(
                                        bottomLeft: Radius.circular(15))
                                    : (index == (listItems.length - 1) &&
                                            index % 3 == 0)
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(15))

                                        // Validacion para el borde inferior derecho
                                        : (index == (listItems.length - 1) &&
                                                (index + 1) % 3 == 0)
                                            ? BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15))
                                            : BorderRadius.circular(0.0),
                child: SizedBox(
                  child: Image.network(
                    IdtConstants.url_image + item.image!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                    child: Text(item.title!.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            textTheme.textWhiteShadow.copyWith(fontSize: 11))),
              ),
            ],
          ),
        ));

    Widget gridImagesCol3() => (GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 5,
          //childAspectRatio: 7/6,
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: _places.asMap().entries.map((entry) {
            final int index = entry.key;
            final DataPlacesDetailModel value = entry.value;

            return imagesCard(value, index, _places);
          }).toList(),
        ));

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 20,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(color: IdtColors.white),
                child: Center(child: TitleSection('ACTIVIDAD RECIENTE')),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Divider(
                  color: IdtColors.black,
                  height: 2,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 15),
              gridImagesCol3(),
              SizedBox(height: 55),
            ],
          ),
        ),
        menuTap,
        loading,
        menu,
      ],
    );
  }
}
