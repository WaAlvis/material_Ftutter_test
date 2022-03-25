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
          const AppbarCircles(hAppbar: hAppbar),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: size.height - hAppbar),
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
                              '# referencia: ${item.advertisement.id.substring(0, 5)}',
                              style: textTheme.textGray,
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
                                  const SizedBox(width: 6),
                                  // TODO: Calcular tiempo restante de la publicacion
                                  Text(
                                    DateTime.fromMillisecondsSinceEpoch(
                                              item.advertisement.expiredDate,
                                            )
                                                .difference(
                                                  DateTime.now(),
                                                )
                                                .inDays >
                                            0
                                        ? '${DateTime.fromMillisecondsSinceEpoch(
                                            item.advertisement.expiredDate,
                                          ).difference(
                                              DateTime.now(),
                                            ).inDays.toString()} d'
                                        : '0 d',
                                    style: textTheme.textWhite,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        /* Text('dias ${item.advertisement.expiredDate}'),
                        const SizedBox(
                          height: 20,
                        ), */
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            const Icon(
                              Icons.account_circle,
                              size: 30,
                              color: LdColors.orangePrimary,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.25),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  item.user.nickName,
                                  style: textTheme.textSmallBlack,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              height: 28,
                              child: VerticalDivider(color: LdColors.blackText),
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
                              item.user.rateBuyer.toString(),
                              style: textTheme.textSmallBlack,
                            ),
                            const Spacer(),
                            const SizedBox(
                              height: 28,
                              child: VerticalDivider(
                                color: LdColors.blackText,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Ver perfil',
                              style: textTheme.textSmallBlack.copyWith(
                                color: LdColors.orangePrimary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        CardDetailOffer(
                          item: item,
                          textTheme: textTheme,
                          viewModel: viewModel,
                        ),
                        /* Text(
                          item.advertisement.advertisementPayAccount[0].bankId,
                        ), */
                        const SizedBox(height: 30),
                        Text(
                          'Bancos',
                          style: textTheme.textGray.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          // TODO: Solicitar que el servicio retorne BankName
                          item.advertisement.advertisementPayAccount
                              .map(
                                (e) => /* '${e.bankId}, ' */ 'Bancolombia, Nequi.',
                              )
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', ''),
                          style: textTheme.textBlack,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Información adicional',
                          style: textTheme.textGray.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.advertisement.termsOfTrade.isEmpty
                              ? 'No hay información adicional.'
                              : item.advertisement.termsOfTrade,
                          style: item.advertisement.termsOfTrade.isEmpty
                              ? textTheme.textGray
                              : textTheme.textBlack,
                        ),
                        const SizedBox(height: 30),
                        InputTextCustom(
                          'Establece una palabra secreta para para asegurar tu inversion',
                          hintText: 'Escribe tu palabra secreta',
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
                        const SizedBox(height: 30),
                        PrimaryButtonCustom(
                          'Separar oferta de compra DLYCOP',
                          onPressed: viewModel.onClickReserveDly,
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
