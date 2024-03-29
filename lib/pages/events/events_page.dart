import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/view_model.dart';
import 'package:bogota_app/widget/menu_tap.dart';
import 'package:bogota_app/extensions/idt_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:intl/intl.dart';
import 'package:bogota_app/pages/events/events_effect.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/events/events_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import 'events_effect.dart';

class EventsPage extends StatelessWidget {
  static String namePage = '';

  final SocialEventType type;
  final int? optionIndex;

  EventsPage({required this.type, this.optionIndex});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          EventsViewModel(locator<IdtRoute>(), locator<ApiInteractor>(), type),
      builder: (context, _) {
        return EventsWidget(optionIndex);
      },
    );
  }
}

class EventsWidget extends StatefulWidget {
  final int? optionIndex;

  EventsWidget(this.optionIndex);

  @override
  _EventsWidgetState createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  bool _nearToMe = false;
  final scrollController = ScrollController();
  StreamSubscription<EventsEffect>? _effectSubscription;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<EventsViewModel>().onInit();
    });
    final viewModel = context.read<EventsViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is EventsValueControllerScrollEffect) {
        scrollController.animateTo(
            event.next
                ? scrollController.offset + IdtConstants.itemSize
                : scrollController.offset - IdtConstants.itemSize,
            curve: Curves.linear,
            duration: Duration(milliseconds: event.duration));
      } else if (event is ShowDialogEffect) {
        context.showDialogObservation(
            titleDialog: 'Sin resultados',
            bodyTextDialog:
                'No se han encotrado resultados para la localidad especificada',
            textPrimaryButton: 'aceptar / cerrar');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EventsViewModel>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: viewModel.offMenuBack,
        child: Scaffold(
            appBar: IdtAppBar(viewModel.openMenu),
            backgroundColor: IdtColors.white,
            extendBody: true,
            extendBodyBehindAppBar: true,
            floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
            bottomNavigationBar:
                viewModel.status.openMenu ? null : IdtBottomAppBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: _buildDiscover(viewModel)),
      ),
    );
  }

  _getOptionIndexForMenu(String title) {
    if (title == 'Evento') {
      return TitlesMenu.eventos;
    }
    if (title == 'Dónde dormir') {
      return TitlesMenu.dondeDormir;
    }
    if (title == 'Dónde comer') {
      return TitlesMenu.dondeComer;
    }
    return TitlesMenu.eventos;
  }

  Widget _buildDiscover(EventsViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;

    final String title = viewModel.status.title;
    final String nameFilter = viewModel.status.nameFilter;
    final isEvent = viewModel.type == SocialEventType.EVENT;

    final List<DataModel> _zones = viewModel.status.zones;

    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: viewModel.status.openMenu
          ? Padding(
              padding: EdgeInsets.only(top: 70),
              child: IdtMenu(
                closeMenu: viewModel.closeMenu,
                optionIndex: _getOptionIndexForMenu(title),
              ),
            )
          : SizedBox.shrink(),
    );

    final menuTap = viewModel.status.openMenuTab
        ? IdtMenuTap(
            listItems: viewModel.status.zones,
            closeMenu: viewModel.closeMenuTab,
            isBlue: true,
            goFilters: (item) =>
                viewModel.filtersForZones(item, viewModel.status.section))
        : SizedBox.shrink();

    Widget _buttonFilter() {
      return Row(
        children: [
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: viewModel.status.openMenuTab
                  ? IdtColors.white
                  : IdtColors.blue.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: IdtColors.grayBtn, width: 0.5),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  )),
              onPressed: () => viewModel.openMenuTab(
                _zones,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            nameFilter.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: textTheme.textDetail.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  Positioned(
                      right: 15,
                      child: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: IdtColors.blue,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget imagesCard(int index, int totalItems, DataModel model) {
      final imageUrl = viewModel.getImageUrl(model);
      late String month, dayOfMonth;
      if (isEvent) {
        final String dateMmmDdd =
            DateFormat('MMMd', 'es').format(DateTime.parse(model.date!));
        month = dateMmmDdd.split(" ").first;
        dayOfMonth = dateMmmDdd.split(" ").last;
      }

      return (Center(
        child: Stack(
          children: <Widget>[
            InkWell(
              onTap: () =>
                  viewModel.goDetailPage(model.id.toString(), viewModel.type),
              child: ClipRRect(
                borderRadius:
                    // Validacion para el borde superior izquiero
                    (index == 0)
                        ? BorderRadius.only(topLeft: Radius.circular(15))

                        // Validacion para el borde superior derecho
                        : (index == 2)
                            ? BorderRadius.only(topRight: Radius.circular(15))

                            // Validaciones para el borde inferior izquiero
                            : (index == (totalItems - 3) && index % 3 == 0)
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(15))
                                : (index == (totalItems - 2) && index % 3 == 0)
                                    ? BorderRadius.only(
                                        bottomLeft: Radius.circular(15))
                                    : (index == (totalItems - 1) &&
                                            index % 3 == 0)
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(15))

                                        // Validacion para el borde inferior derecho
                                        : (index == (totalItems - 1) &&
                                                (index + 1) % 3 == 0)
                                            ? BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15))
                                            : BorderRadius.circular(0.0),
                child: SizedBox(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // child: Image.network(
                  //   imageUrl,
                  //   height: 200,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                  padding: isEvent
                      ? EdgeInsets.only(left: 5.0)
                      : EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: AutoSizeText(
                          model.title!.toUpperCase(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          style: textTheme.textWhiteShadow,
                        ),
                      ),
                      isEvent
                          ? Container(
                              margin: EdgeInsets.only(left: 3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  gradient: LinearGradient(
                                      colors: IdtGradients.orange),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                  )),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 3),
                              child: Column(
                                children: [
                                  Text(dayOfMonth,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: textTheme.textButtomWhite.copyWith(
                                        fontSize: 16,
                                      )),
                                  Text(month,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: textTheme.textButtomWhite.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  )),
            ),
          ],
        ),
      ));
    }

    Widget gridImagesCol3(List<DataModel> listItems) => (GridView.count(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 3,
        mainAxisSpacing: 5,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: List.generate(listItems.length, (index) {
          return imagesCard(index, listItems.length, listItems[index]);
        })));

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: IdtColors.orange,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(bottom: 10),
                height: 100,
                alignment: Alignment.bottomCenter,
                child: Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleWhite,
                ),
              ),

              viewModel.type != SocialEventType.EVENT
                  ? _buttonFilter()
                  : SizedBox.shrink(),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Switch.adaptive(
                    value: viewModel.status.switchCloseToMe,
                    onChanged: (bool value) {
                      viewModel.getEventsCloseToMe(value, viewModel.type);
                    },
                    activeColor: IdtColors.greenDark,
                  ),
                  Text(
                    'Cerca de mi',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              //Coment porque no llega con localidad el servicio
              // Column(
              //   children: [
              //     SizedBox(height: 10,),
              //     Switch.adaptive(
              //       value: _nearToMe,
              //       onChanged: (bool value) {
              //         setState(() {
              //           print(value);
              //           _nearToMe = value;
              //           print(_nearToMe);
              //
              //         });
              //       },
              //       activeColor: IdtColors.greenDark,
              //     ),
              //     Text('Cerca de mi', style: TextStyle(fontWeight: FontWeight.w700),),
              //
              //   ],
              // ),
              SizedBox(height: 15),
              gridImagesCol3(viewModel.status.places),
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
