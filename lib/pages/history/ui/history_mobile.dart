part of 'history_view.dart';

class HistoryMobile extends StatelessWidget {
  const HistoryMobile({
    Key? key,
    required this.keyForm,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    const List<DayOperation> listOperationByDay = <DayOperation>[
      DayOperation(
        <Operation>[
          Operation('1.000.000', '1.2'),
          Operation('120.000', '1.0'),
          Operation('10.000.000', '0.8'),
          Operation('12.000.000', '1.2'),
        ],
        date: 'Noviembre 02 de 2021',
      ),
      // DayOperation(
      //   <Operation>[
      //     Operation('15.000.000', '1.2'),
      //     Operation('500.000', '1.5'),
      //     Operation('200.000', '0.8'),
      //     Operation('1.000.000', '1.2'),
      //   ],
      //   date: 'Octubre 12 de 2021',
      // ),
      // DayOperation(
      //   <Operation>[
      //     Operation('1.000.000', '0.9'),
      //     Operation('10.500.000', '1.5'),
      //     Operation('20.000.000', '1.1'),
      //     Operation('12.000.000', '1.2'),
      //   ],
      //   date: 'Octubre 02 de 2021',
      // )
    ];

    // <DayOperation>[
    //   (DayOperation(operations, date: date)
    //       <Operation>[
    //         Operation('1.000.000', '1.2'),
    //         Operation('1.000.000', '1.2'),
    //         Operation('1.000.000', '1.2'),
    //         Operation('1.000.000', '1.2'),
    //       ],
    //       date: 'Noviembre 02 de 2021',
    //   )
    // ];
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
                    ListView.builder(
                      itemCount: listOperationByDay.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListOperationDay(
                          textTheme,
                          listOperationByDay,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListOperationDay extends StatelessWidget {
  const ListOperationDay(
    this.textTheme,
    this.dayOerations,
  );

  final TextTheme textTheme;
  final List<DayOperation> dayOerations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dayOerations.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                 dayOerations[index].date,
                  textAlign: TextAlign.left,
                  style: textTheme.textGray.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: LdColors.green.withOpacity(0.07),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'DLYCOP comprados',
                          style: textTheme.textBlack,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dayOerations[index].operations[index].amount,
                              style: textTheme.textBigBlack.copyWith(
                                color: LdColors.green,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              LdAssets.dlycopIconGreen,
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

  const Operation(this.amount, this.margin);
}
