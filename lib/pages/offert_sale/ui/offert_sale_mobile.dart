part of 'offert_sale_view.dart';

class _OffertSaleMobile extends StatelessWidget {
  const _OffertSaleMobile(
      {Key? key,
      required this.keyForm,
      required this.valueDLYCOP,
      required this.plusInfoCtrl,
      vo})
      : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController valueDLYCOP;
  final TextEditingController plusInfoCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OffertSaleViewModel viewModel = context.watch<OffertSaleViewModel>();
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: LdColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Oferta de venta',
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
                  '¿Cuantos DLYCOP vas a vender?*',
                  style: textTheme.textBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                OrangeTableSummary(
                  textTheme: textTheme,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Bancos para resivir el pago',
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
                  controller: plusInfoCtrl,
                  minLines: 5,
                  //Normal textInputField will be displayed
                  maxLines: 5,
                  // when user presses enter it will adapt to it
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  )),
                ),
                const Text('Tiempo estiamdo en una cart gris'),
                PrimaryButtonCustom('Crear oferta de venta', onPressed: () {
                  if (keyForm.currentState!.validate()) {
                    viewModel.postCreateOffert(
                      context,
                      valueDLYCOP,
                      plusInfoCtrl,
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
