part of 'offert_buy_view.dart';

class _OffertBuyMobile extends StatelessWidget {
  const _OffertBuyMobile(
      {Key? key,
      required this.keyForm,
      required this.valueDLYCOP,
      required this.infoPlusOffertCtrl,
      vo})
      : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController valueDLYCOP;
  final TextEditingController infoPlusOffertCtrl;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OffertBuyViewModel viewModel = context.watch<OffertBuyViewModel>();
    final Size size = MediaQuery.of(context).size;
    final double hAppbar = size.height * 0.14;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      appBar: const LdAppbar(
        title: 'Crear oferta',
        // withBackIcon: false,
      ),
      body: Column(children: [
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Oferta de compra',
                            style: textTheme.subtitleBlack.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Ingresa la informacion de la publicacion.',
                            style: textTheme.textBlack,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InputTextCustom(
                            'Valor de los DLYCOP*',
                            controller: valueDLYCOP,
                            hintText: '0',
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            '¿Cuantos DLYCOP vas a comprar?*',
                            style: textTheme.textBlack,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OrangeTableBuy(
                            textTheme: textTheme,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Bancos para recibir el pago',
                            style: textTheme.textBigBlack,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Esta imformacion solo se mostrar al usuario que comfirme la compra de tus Dailys y servirá para que pueda hacer el pago correspondiente.',
                            style: textTheme.textGray,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // DropdownCustom(
                          //   'Banco *',
                          //   hintText: 'Seleciona tu banco',
                          //   optionItems: viewModel.status.listBanks.data
                          //       .map((Bank item) {
                          //     return DropdownMenuItem<String>(
                          //       value: item.id,
                          //       child: Text(item.description),
                          //     );
                          //   }).toList(),
                          // ),
                          const InputTextCustom(
                            'Banco *',
                            hintText: 'Seleciona tu banco',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PrimaryButtonCustom(
                            'Agregar Banco',
                            icon: Icons.add_circle_outline_outlined,
                            colorButton: LdColors.white,
                            colorTextBorder: LdColors.orangePrimary,
                            onPressed: () => viewModel,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Informacion adicional (opcional)'),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            controller: infoPlusOffertCtrl,
                            minLines: 5,
                            //Normal textInputField will be displayed
                            maxLines: 5,
                            // when user presses enter it will adapt to it
                            decoration: const InputDecoration(
                                hintText:
                                    'Ingresa informacion adicional para los compradores...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 150,
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                              right: 25,
                              left: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: LdColors.grayBorder,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.timer,
                                  size: 70,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'La oferta Expirará en  ',
                                      style: textTheme.textBlack,
                                      children: const <TextSpan>[
                                        TextSpan(
                                          text: '7 dias ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                'desde el momento de la publicación.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PrimaryButtonCustom('Crear oferta de venta',
                              onPressed: () {
                            if (keyForm.currentState!.validate()) {
                              viewModel.buyCreateOffert(
                                context,
                                valueDLYCOP,
                                infoPlusOffertCtrl,
                                userProvider.getUserLogged!.id,
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

// class DropdownCustom extends StatelessWidget {
//   const DropdownCustom(
//     this.data, {
//     Key? key,
//     required this.hintText,
//     required this.optionItems,
//     // this.styleLabel,
//     // this.styleHint,
//     // this.suffixIcon,
//   }) : super(key: key);
//
//   final String data;
//   final String hintText;
//   final List<DropdownMenuItem<String>>? optionItems;
//
//   @override
//   Widget build(BuildContext context) {
//     final OffertBuyViewModel viewModel = context.watch<OffertBuyViewModel>();
//
//     final TextTheme textTheme = Theme.of(context).textTheme;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: Text(
//             data,
//             style: textTheme.textBlack,
//           ),
//         ),
//         const SizedBox(
//           height: 12,
//         ),
//         DropdownButtonFormField<String>(
//           value: viewModel.status.selectedBank?.id,
//           // hint: const Text('Seleciona tu banco'),
//           decoration: InputDecoration(
//             border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(12.0),
//               ),
//             ),
//             filled: viewModel.status.selectedBank != null,
//             hintText: hintText,
//             fillColor: LdColors.whiteDark,
//           ),
//           items: optionItems,
//           onChanged: (String? idBank) => viewModel.bankSelected(idBank!),
//         ),
//       ],
//     );
//   }
// }
