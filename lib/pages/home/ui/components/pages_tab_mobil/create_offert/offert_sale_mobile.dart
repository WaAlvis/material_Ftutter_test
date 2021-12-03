part of '../../../home_view.dart';

class OffertSaleMobile extends StatelessWidget {
  const OffertSaleMobile({
    Key? key,
    // required this.keyForm,
    // required this.passwordCtrl,
    // required this.userCtrl,
  }) : super(key: key);

  // final GlobalKey<FormState> keyForm;
  // final TextEditingController passwordCtrl;
  // final TextEditingController userCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: LdColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
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
              const InputTextCustom(
                'Valor de los DLYCOP',
                hintText: '0',
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                '¿Cuantos DLYCOP vas a vender?*',
                style: textTheme.textBigBlack,
              ),
              const SizedBox(
                height: 20,
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
              const InputTextCustom('Banco *', hintText: 'Seleciona tu banco'),
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
              const TextField(
                keyboardType: TextInputType.multiline,
                minLines: 5, //Normal textInputField will be displayed
                maxLines: 5, // when user presses enter it will adapt to it
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
