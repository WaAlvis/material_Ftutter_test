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
                const SizedBox(
                  height: hAppbar,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    color: LdColors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
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
                        Text(
                          '# de referencia ${item.advertisement.id}',
                          style: textTheme.textBlack,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('dias ${item.advertisement.expiredDate}'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.person_pin),
                            Divider(
                              indent: 10,
                              color: LdColors.blackDark,
                              height: 10,
                            ),
                            Text(item.user.nickName),
                            Icon(Icons.star_half),
                            Text(item.user.rateBuyer),
                            Text(
                              'Ver perfil',
                              style: TextStyle(
                                  color: LdColors.orangePrimary,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        CardDetailOffer(
                          item: item,
                          textTheme: textTheme,
                          viewModel: viewModel,
                        ),
                        Text(item
                            .advertisement.advertisementPayAccount[1].bankId),
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
                            item: item
                          ),
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
