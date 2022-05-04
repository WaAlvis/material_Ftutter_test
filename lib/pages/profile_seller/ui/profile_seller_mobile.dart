part of 'profile_seller_view.dart';

class _ProfileSellerMobile extends StatelessWidget {
  const _ProfileSellerMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
    required this.userCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;
  final TextEditingController userCtrl;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final ProfileSellerViewModel viewModel =
        context.watch<ProfileSellerViewModel>();
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 160;
    final double hBody = size.height - hAppbar;

    final double ratingSellerTest = viewModel.status.infoUserPublish?.rateGeneral ?? 1;

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: LdColors.blackBackground,
        appBar: const LdAppbar(
          title: 'Perfil del comprador',
        ),
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const AppbarCircles(
                  hAppbar: hAppbar,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxHeight: hBody),
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 16,
                          right: 16,
                          bottom: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: LdColors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 50,
                            ),
                            _nameUser(textTheme),
                            const SizedBox(
                              height: 12,
                            ),
                            const Spacer(),
                            _containerRateSeller(ratingSellerTest, textTheme),
                            const SizedBox(
                              height: 12,
                            ),
                            const Spacer(),
                            Column(
                              children: <Widget>[
                                _summaryOperationsRow(
                                  textTheme,
                                  hBody,
                                  title: 'Operaciones',
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                _summaryOperationsRow(
                                  textTheme,
                                  hBody,
                                  title: 'Ofertas publicadas',
                                ),
                              ],
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            PrimaryButtonCustom(
                              'Ver más ofertas',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    _circleAvatar(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _summaryOperationsRow(
    TextTheme textTheme,
    double hBody, {
    required String title,
  }) {
    // final String title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: textTheme.textBlack.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            _counterOperationsContainer(textTheme),
            const SizedBox(
              width: 12,
            ),
            _counterOperationsContainer(textTheme),
          ],
        )
      ],
    );
  }

  Widget _counterOperationsContainer(TextTheme textTheme) {
    return Expanded(
      child: Container(
        // height: 100,
        constraints: const BoxConstraints(maxHeight: 100, minHeight: 60),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: LdColors.grayButton,
        ),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Text(
              '125',
              style: textTheme.textBigBlack.copyWith(
                color: LdColors.blackBackground,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Text(
                'ventas realizadas',
                style: textTheme.textSmallBlack.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _containerRateSeller(
    double ratingSellerTest,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.only(
        top: 22,
        bottom: 12,
        left: 12,
        right: 12,
      ),
      decoration: BoxDecoration(
        color: LdColors.orangePrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ratingSellerTest.toString(),
                style: textTheme.textBigBlack.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: LdColors.white,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              RateStars(
                ratingSellerTest: ratingSellerTest,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Calificación general',
            style: textTheme.textSmallWhite,
          )
        ],
      ),
    );
  }

  Column _nameUser(TextTheme textTheme) {
    return Column(
      children: <Widget>[
        SizedBox(
          child: Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'UsuV2021',
                style: textTheme.textBigBlack
                    .copyWith(fontSize: 26, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'usuario desde el 2010',
          style: textTheme.textSmallBlack.copyWith(
            color: LdColors.gray,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _circleAvatar() {
    const double size = 100;
    return Positioned(
      top: -size * 0.5,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const Icon(
            Icons.account_circle,
            color: LdColors.blackBackground,
            size: size,
          ),
        ],
      ),
    );
  }
}

class RateStars extends StatelessWidget {
  const RateStars({
    Key? key,
    required this.ratingSellerTest,
  }) : super(key: key);

  final double ratingSellerTest;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 30,
      // ignoreGestures: true,
      initialRating: ratingSellerTest,
      minRating: 1,
      allowHalfRating: true,
      itemBuilder: (BuildContext context, _) => const Icon(
        Icons.star,
        color: LdColors.white,
      ),
      onRatingUpdate: (double rating) {
        print(rating);
      },
    );
  }
}
