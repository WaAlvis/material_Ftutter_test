import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/widgets/primary_button.dart';

class Step6RestoreWallet extends StatelessWidget {
  const Step6RestoreWallet({
    Key? key,
    required this.keyForm,
    required this.viewModel,
    required this.phraseCtrl,
    required this.dataUserProvider,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;
  final RegisterViewModel viewModel;

  final TextEditingController phraseCtrl;

  final DataUserProvider dataUserProvider;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    int phraseLength = 0;
    if (viewModel.status.phrase.isNotEmpty) {
      phraseLength = viewModel.status.phrase
          .split(' ')
          .where((String element) => element != '')
          .length;
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'La informacion aqui proporcionada solo sera utilizada para validar la propiedad de tu direccion Wallet y sera almacenada de manera segura',
                      style: textTheme.textSmallBlack,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Es necesaria tu direccion para realizaar trasaciones en LocalDaily',
                      style: textTheme.textSmallBlack,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'Por favor ingresa tu frase de seguridad, ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'ubicando las 12 palabras en el orden indicado',
                          ),
                          TextSpan(
                            text:
                                ' y dejando un espacio entre cada una de ellas.',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      child: TextFormField(
                        validator: (_) => viewModel
                            .validatorNotEmpty(viewModel.status.addressWallet),
                        controller: phraseCtrl,
                        keyboardType: TextInputType.multiline,
                        enableSuggestions: false,
                        autocorrect: false,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: textTheme.textGray,
                        onChanged: viewModel.onChangePhrase,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: LdColors.blackBackground,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          helperStyle: textTheme.textBlack,
                        ),
                      ),
                    ),

                    Text(
                      '$phraseLength de 12 palabras',
                      textAlign: TextAlign.center,
                      style: textTheme.textBlack.copyWith(
                        fontWeight: FontWeight.w700,
                        color: phraseLength != 12
                            ? LdColors.orangeWarning
                            : LdColors.green,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ElevatedButton(
                      onPressed: phraseLength != 12
                          ? null
                          : () {
                              viewModel.validateAddress(phraseCtrl.text);
                            },
                      child: Text('Validar'),
                    ),
                    const SizedBox(height: 16),

                    if (viewModel.status.addressWallet.isEmpty)
                      const SizedBox.shrink()
                    else
                      Row(
                        children: const <Widget>[
                          Icon(Icons.check),
                          Text('Wallet Validad con Exito'),
                        ],
                      ),
                    if (viewModel.status.addressWallet.isEmpty)
                      const SizedBox.shrink()
                    else
                      Text(
                        viewModel.status.addressWallet,
                        style: textTheme.textSmallBlack
                            .copyWith(fontWeight: FontWeight.w800),
                      ),

                    const SizedBox(height: 16),

                    // PrimaryButtonCustom(
                    //   'Registrar',
                    //   onPressed: () {
                    //     // if (keyForm.currentState!.validate()) {
                    //     viewModel.finishRegister(context, dataUserProvider);
                    //     // }
                    //   },
                    // )
                  ],
                ),
                PrimaryButtonCustom(
                  'Registrarse',
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      viewModel.finishRegister(context, dataUserProvider);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecoverPhrase(
      BuildContext context, RegisterViewModel viewModel, int phraseLength) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constrain) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constrain.maxHeight),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RichText(
                      text: const TextSpan(
                        text: 'Por favor ingresa tu frase de seguridad, ',
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'ubicando las 12 palabras en el orden indicado',
                          ),
                          TextSpan(
                            text:
                                ' y dejando un espacio entre cada una de ellas.',
                          )
                        ],
                      ),
                    ),
                    Form(
                      key: keyForm,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        child: TextFormField(
                          controller: phraseCtrl,
                          keyboardType: TextInputType.multiline,
                          enableSuggestions: false,
                          autocorrect: false,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: textTheme.textGray,
                          onChanged: viewModel.onChangePhrase,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: LdColors.blackBackground,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            helperStyle: textTheme.textBlack,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '$phraseLength de 12 palabras',
                      style: textTheme.textBlack.copyWith(
                        fontWeight: FontWeight.w700,
                        color: phraseLength > 12
                            ? LdColors.orangeWarning
                            : LdColors.green,
                      ),
                    )
                  ],
                ),
                const SizedBox.shrink(),
                Column(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundColor: LdColors.yellow,
                        minRadius: size.width * 0.15,
                        child: Container(
                          margin: EdgeInsets.only(right: size.width * 0.05),
                          child: Icon(
                            Icons.label,
                            color: LdColors.grayBg,
                            size: size.width * 0.15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Para disfrutar tus Dailys',
                    ),
                    Text(
                      'recupera tu Wallet Crypto',
                      style: textTheme.subtitleWhite.copyWith(),
                    )
                  ],
                ),
                const SizedBox.shrink()
              ],
            ),
          ),
        );
      },
    );
  }

  Row checkRowValidation(String title, {required bool? value}) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 24,
          child: Checkbox(
            activeColor: LdColors.orangePrimary,
            value: value,
            onChanged: (_) {},
          ),
        ),
        Flexible(
          child: Text(title),
        ),
      ],
    );
  }
}
