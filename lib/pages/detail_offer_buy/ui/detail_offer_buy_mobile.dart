part of 'detail_offer_buy_view.dart';

class _DetailOfferBuyMobile extends StatelessWidget {
  const _DetailOfferBuyMobile({
    Key? key,
    required this.keyForm,
    required this.item,
    required this.secretWordCtrl,
  }) : super(key: key);

  final Data item;
  final TextEditingController secretWordCtrl;
  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final DetailOfferBuyViewModel viewModel =
        context.watch<DetailOfferBuyViewModel>();
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body
    const double hAppbar = 100;
    final double hBody = size.height - hAppbar;

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus || !currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: LdColors.blackBackground,
        appBar: const LdAppbar(
          title: 'Detalles de la operación',
          // withBackIcon: false,
        ),
        body: Column(children: <Widget>[
          Container(
            width: size.width,
            color: LdColors.blackBackground,
            child: const AppbarCircles(hAppbar: hAppbar),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Comprar DLYCOP',
                          style: textTheme.subtitleBlack.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Codigo referencia: ${item.advertisement.id.substring(0, 5)}',
                              style: textTheme.textBlack,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                color: LdColors.orangePrimary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.event,
                                    color: LdColors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    item.advertisement.expiredDate.length > 2
                                        ? '7 d'
                                        : item.advertisement.expiredDate,
                                    style:
                                        const TextStyle(color: LdColors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('dias ${item.advertisement.expiredDate}'),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Icon(
                                Icons.account_circle,
                                size: 40,
                                color: LdColors.orangePrimary,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(item.user.nickName),
                              const Spacer(),
                              const SizedBox(
                                height: 25,
                                child:
                                    VerticalDivider(color: LdColors.blackText),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.star,
                                color: LdColors.orangePrimary,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                item.user.rateBuyer != '0'
                                    ? item.user.rateBuyer
                                    : '1.0',
                              ),
                              const Spacer(),
                              const SizedBox(
                                  height: 35,
                                  child: VerticalDivider(
                                    color: LdColors.blackText,
                                  )),
                              const Spacer(),
                              const Text(
                                'Ver perfil',
                                style: TextStyle(
                                    color: LdColors.orangePrimary,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        CardDetailOffer(
                          item: item,
                          textTheme: textTheme,
                          viewModel: viewModel,
                        ),
                        Text(item
                            .advertisement.advertisementPayAccount[0].bankId),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextCustom(
                          'Establece una palabra para para asegurar tu invercion',
                          hintText: 'secret*',
                          validator: (String? value) =>
                              viewModel.validatorNotEmpty(value),
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9a-zA-Z.]'),
                            ),
                          ],
                          controller: secretWordCtrl,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PrimaryButtonCustom(
                          'Separar oferta de compra DLYCOP',
                          onPressed: () => viewModel.reservationPaymentForDly(
                              context,
                              wordSecretBuyer: secretWordCtrl.text,
                              item: item,
                              userCurrent: dataUserProvider.getDataUserLogged!),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
