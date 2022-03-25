part of 'history_view.dart';

class HistoryMobile extends StatelessWidget {
  const HistoryMobile({
    Key? key,
    required this.keyForm,
    required this.scrollCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context) {
    final HistoryViewModel viewModel = context.watch<HistoryViewModel>();
    // final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 150;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      // appBar: const LdAppbar(
      //   title: 'Historial',
      //   withBackIcon: true,
      // ),
      body: Column(
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
                SizedBox(
                  height: hAppbar,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () => viewModel.goBack(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: LdColors.white,
                          ),
                        ),
                        Text(
                          'Historial',
                          style: textTheme.textBigWhite,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: hBody),
              decoration: const BoxDecoration(
                color: LdColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RowOptionsFilter(
                    quantityFilter: 5,
                    textTheme: textTheme,
                  ),
                  if (viewModel.status.daysMockHistory.isEmpty)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    ListView.separated(
                      controller: scrollCtrl,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: viewModel.status.daysMockHistory.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            dateHeader(viewModel.status.daysMockHistory, index,
                                textTheme),
                            ListOperationDay(
                              viewModel,
                              textTheme,
                              viewModel.status.daysMockHistory[index],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            thickness: 2,
                          ),
                        );
                      },
                    )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Padding dateHeader(
      List<DayOperation> listOperationByDay, int index, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 16, right: 32),
      child: Text(
        listOperationByDay[index].date,
        textAlign: TextAlign.left,
        style: textTheme.textGray.copyWith(
          fontSize: 12,
        ),
      ),
    );
  }
}

class ListOperationDay extends StatelessWidget {
  const ListOperationDay(
    this.viewModel,
    this.textTheme,
    this.dayOperations,
  );

  final HistoryViewModel viewModel;
  final TextTheme textTheme;
  final DayOperation dayOperations;

  Color get orangeSlash => LdColors.orangeWarning;

  Color get greenSplash => LdColors.green;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: dayOperations.operations.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  highlightColor:
                      dayOperations.operations[index].amount.contains('-')
                          ? orangeSlash.withOpacity(0.1)
                          : greenSplash.withOpacity(0.1),
                  splashColor:
                      dayOperations.operations[index].amount.contains('-')
                          ? orangeSlash.withOpacity(0.2)
                          : greenSplash.withOpacity(0.2),
                  focusColor: LdColors.orangePrimary.withOpacity(0.4),
                  onTap: () => viewModel.goDetailHistoryOperation(context,
                      item: dayOperations.operations[index]),
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //   content: Text('Tap'),
                  // ));
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // color: LdColors.green.withOpacity(0.07),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dayOperations.operations[index].amount
                                      .contains('-')
                                  ? 'DLYCOP vendidos'
                                  : 'DLYCOP comprados',
                              style: textTheme.textBlack,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  dayOperations.operations[index].amount,
                                  style: textTheme.textBigBlack.copyWith(
                                    color: dayOperations
                                            .operations[index].amount
                                            .contains('-')
                                        ? orangeSlash
                                        : greenSplash,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  dayOperations.operations[index].amount
                                          .contains('-')
                                      ? LdAssets.dlycopIconRed
                                      : LdAssets.dlycopIconGreen,
                                  height: 30,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '1 DLYCOP ≈ 1 COP',
                              style: textTheme.textGray.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '= 1.000.000 COP',
                              style: textTheme.textSmallBlack,
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class RowOptionsFilter extends StatelessWidget {
  //mover a mainOffer Home
  const RowOptionsFilter({
    Key? key,
    required this.textTheme,
    required this.quantityFilter,
  }) : super(key: key);

  final int quantityFilter;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 32,
        right: 32,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Ventas y compras',
            style: textTheme.textBlack,
          ),
          Row(
            children: [
              const Icon(Icons.filter_alt_outlined),
              Text(
                'Filtros ($quantityFilter)',
                style: textTheme.textSmallBlack,
              )
            ],
          )
        ],
      ),
    );
  }
}

class DayOperation {
  final List<Operation> operations;
  final String date;

  const DayOperation(this.operations, {required this.date});
}

class Operation {
  final String amount;
  final String margin;
  final String nickname;
  final String rate;

  const Operation(this.amount, this.margin, this.nickname, this.rate);
}
