part of 'support_cases_view.dart';

class _SupportCasesMobile extends StatelessWidget {
  const _SupportCasesMobile({Key? key, required this.supportScrollCtrl})
      : super(key: key);

  final ScrollController supportScrollCtrl;

  @override
  Widget build(BuildContext context) {
    const double hAppbar = 120;
    final Size size = MediaQuery.of(context).size;

    final SupportCasesViewModel viewModel =
        context.watch<SupportCasesViewModel>();
    final DataUserProvider userProvider = context.read<DataUserProvider>();
    final List<BodyContactSupport> items =
        viewModel.status.resultSupportCases.data;
    final TextTheme textTheme = Theme.of(context).textTheme;


    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      // appBar: const LdAppbar(title: 'Servicio al cliente'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBarBigger(
            title: 'Servicio al cliente',
            hAppbar: hAppbar,
            textTheme: textTheme,
          ),
          // const AppbarCircles(hAppbar: hAppbar),
          Container(
            height: size.height - hAppbar,
            constraints: BoxConstraints(
              minHeight: size.height - hAppbar,
              maxHeight: size.height - hAppbar,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
            decoration: const BoxDecoration(
              color: LdColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: RefreshIndicator(
              color: LdColors.orangePrimary,
              onRefresh: () async {
                await viewModel.getData(
                  userProvider.getDataUserLogged?.id ?? '',
                  context,
                  refresh: true,
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                shrinkWrap: items.isEmpty,
                itemCount: viewModel.status.isLoading
                    ? 10
                    : items.length,
                controller: supportScrollCtrl,
                itemBuilder: (BuildContext context, int index) {
                  return viewModel.status.isLoading
                      ? Shimmer.fromColors(
                    baseColor: LdColors.whiteDark,
                    highlightColor: LdColors.grayButton,
                    child: const Card(
                      margin: EdgeInsets.all(10),
                      child: SizedBox(height: 100),
                    ),
                  )
                      : items.isEmpty
                      ? const IntrinsicHeight(
                    child: _EmptySupportCases(),
                  )
                      : _SupportCaseCard(item: items[index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _EmptySupportCases extends StatelessWidget {
  const _EmptySupportCases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: AdviceMessage(
            imageName: LdAssets.emptySupport,
            title: 'Aún no tienes casos de soporte',
            description:
                'Cuando abras casos de soporte vuelve acá para revisarlos.',
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}

class _SupportCaseCard extends StatelessWidget {
  const _SupportCaseCard({Key? key, required this.item}) : super(key: key);
  final BodyContactSupport item;

  @override
  Widget build(BuildContext context) {
    print('*** ${item.toString()}');

    final DateFormat format = DateFormat('dd-MM-yyyy hh:mm a');
    final TextTheme textTheme = Theme.of(context).textTheme;
    final SupportCasesViewModel viewModel =
        context.watch<SupportCasesViewModel>();
    final ConfigurationProvider configurationProvider =
        context.read<ConfigurationProvider>();

    return GestureDetector(
      onTap: () {
        print('*** ${item.id}');
        viewModel.goDetailSupport(context, item);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: const BoxDecoration(
          color: LdColors.grayBg,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Caso de soporte',
                  style: textTheme.textBlack.copyWith(
                    fontWeight: FontWeight.w500,
                    color: LdColors.orangePrimary,
                  ),
                ),
                _buildStatus(
                  textTheme,
                  item.idSupportStatus,
                  configurationProvider.getResultSupportStatus!,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.textBlack.copyWith(
                        fontSize: 14,
                        color: LdColors.blackText,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '${item.description} '),
                        TextSpan(
                          // text: format.format(
                          //   DateTime.fromMillisecondsSinceEpoch(
                          //     item.datePublish!,
                          //   ),
                          // ),
                          text: item.datePublish,
                          style: textTheme.textBlack
                              .copyWith(fontSize: 12, color: LdColors.gray),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Icon(
                //   Icons.arrow_forward_ios,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus(
    TextTheme textTheme,
    String idStatus,
    ResultSupportStatus status,
  ) {
    int statusIndex = 0;
    final int index =
        status.data.indexWhere((element) => element.id == idStatus);
    if (index != -1) {
      statusIndex = SupportStatus.values
          .firstWhere(
            (element) => element.index == status.data[index],
            orElse: () => SupportStatus.Abierto,
          )
          .index;
    }
    return Container(
      width: 110,
      constraints: const BoxConstraints(maxWidth: 110),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: statusIndex == 0
            ? LdColors.orangePrimary
            : statusIndex == 1
                ? LdColors.greenState
                : LdColors.blueState,
      ),
      child: Text(
        SupportStatus.values[statusIndex].name,
        style: textTheme.textSmallWhite.copyWith(color: LdColors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
