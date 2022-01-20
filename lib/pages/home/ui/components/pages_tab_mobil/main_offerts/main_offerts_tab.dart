part of '../../../home_view.dart';

class MainOffertsTab extends StatelessWidget {
  const MainOffertsTab({
    required this.viewModel,
    required this.textTheme,
    required this.itemsBuyers,
    required this.itemsSellers,
    required this.hAppbar,
    required this.hBody,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final List<Data> itemsBuyers;
  final List<Data> itemsSellers;
  final double hAppbar;
  final double hBody;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    //Alturas de el APpbar y el body

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: LdAppbar(
        userProvider: userProvider.getUserLogged,
        goLogin: (BuildContext context) => viewModel.goLogin(context),
        // withBackIcon: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              width: size.width,
              color: LdColors.blackBackground,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  // Esto es el circulo, ideal volverlo widget
                  Positioned(
                    right: 0,
                    child: SizedBox(
                      // El tamaño depende del tamaño de la pantalla
                      width: (size.width) / 4,
                      height: (size.width) / 4,
                      child: QuarterCircle(
                        circleAlignment: CircleAlignment.bottomRight,
                        color: LdColors.grayLight.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: SizedBox(
                      width: (size.width) * 2 / 4,
                      height: (size.width) * 2 / 4,
                      child: QuarterCircle(
                        circleAlignment: CircleAlignment.bottomRight,
                        color: LdColors.grayLight.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: SizedBox(
                      width: (size.width) * 3 / 4,
                      height: (size.width) * 3 / 4,
                      child: QuarterCircle(
                        circleAlignment: CircleAlignment.bottomRight,
                        color: LdColors.grayLight.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: hAppbar), //altura del appbar
                    //hijos del contenedor inferior aqui
                  ),
                  Column(
                    children: [
                      TabBar(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        indicatorColor: LdColors.orangePrimary,
                        indicatorWeight: 3,
                        labelColor: Colors.grey,
                        unselectedLabelColor: Colors.red,
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              'Comprar',
                              style: textTheme.textYellow.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: LdColors.orangePrimary),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Vender',
                              style: textTheme.textYellow.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: LdColors.orangePrimary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  ListOffertsMainCards('Ofertas para comprar',
                      textTheme: textTheme,
                      items: itemsBuyers,
                      viewModel: viewModel),
                  ListOffertsMainCards('Ofertas para vender',
                      textTheme: textTheme,
                      items: itemsSellers,
                      viewModel: viewModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TabBarView(
//                 children: <Widget>[
//                   RefreshIndicator(
//                     onRefresh: () async {
//                       // keyRefresh.currentState?.show(atTop: false);
//                       await Future<Duration>.delayed(
//                         const Duration(seconds: 1),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           OptionsFilterRow(
//                             textTheme: textTheme,
//                             quantityFilter: 2,
//                           ),
//                           const Divider(
//                             height: 8,
//                             color: LdColors.gray,
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Text(
//                               'Ofertas para comprar',
//                               textAlign: TextAlign.center,
//                               style: textTheme.textBlack.copyWith(
//                                   fontWeight: FontWeight.w500,
//                                   color: LdColors.orangePrimary),
//                             ),
//                           ),
//                           Expanded(
//                             child: ListView.separated(
//                               separatorBuilder:
//                                   (BuildContext context, int index) {
//                                 return const SizedBox(
//                                   height: 8,
//                                 );
//                               },
//                               // controller: _scrollController,
//                               itemCount: itemsBuyers.length,
//                               itemBuilder:
//                                   (BuildContext context, int index) {
//                                 return CardBuyAndSell(
//                                   index: index,
//                                   items: itemsBuyers,
//                                   textTheme: textTheme,
//                                   viewModel: viewModel, //Pase bien el VM
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   RefreshIndicator(
//                     onRefresh: () async {
//                       // keyRefresh.currentState?.show(atTop: false);
//                       await Future<Duration>.delayed(
//                         const Duration(seconds: 1),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           OptionsFilterRow(
//                               textTheme: textTheme, quantityFilter: 3),
//                           const Divider(
//                             height: 8,
//                             color: LdColors.gray,
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Text(
//                               'Ofertas para vender',
//                               textAlign: TextAlign.center,
//                               style: textTheme.textBlack.copyWith(
//                                   fontWeight: FontWeight.w500,
//                                   color: LdColors.orangePrimary),
//                             ),
//                           ),
//                           Expanded(
//                             child: ListView.separated(
//                               separatorBuilder:
//                                   (BuildContext context, int index) {
//                                 return const SizedBox(
//                                   height: 8,
//                                 );
//                               },
//                               // controller: _scrollController,
//                               itemCount: itemsSellers.length,
//                               itemBuilder:
//                                   (BuildContext context, int index) {
//                                 return CardBuyAndSell(
//                                   index: index,
//                                   items: itemsSellers,
//                                   textTheme: textTheme,
//                                   viewModel: viewModel,
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
