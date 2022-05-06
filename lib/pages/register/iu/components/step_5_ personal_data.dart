import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';

class Step5PersonalData extends StatelessWidget {
  const Step5PersonalData({
    Key? key,
    required this.keyForm,
    required this.viewModel,
    required this.namesCtrl,
    required this.surnamesCtrl,
    required this.phoneCtrl,
    required this.dateBirthCtrl,
    required this.dataUserProvider,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;
  final RegisterViewModel viewModel;
  final TextEditingController namesCtrl;
  final TextEditingController surnamesCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController dateBirthCtrl;
  final DataUserProvider dataUserProvider;

  // final DataUserProvider dataUserProvider;

  @override
  Widget build(BuildContext context) {
    final DateTime dateNow = DateTime.now();
    final DateTime dateAllowed =
        DateTime.utc(dateNow.year - 18, dateNow.month, dateNow.day);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 10),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // if (viewModel.status.isErrorRegisterUser)
                //   WarningContainerMsj(
                //     textTheme,
                //     message: viewModel.status.msjErrorRegisterUser,
                //     onTap: () => viewModel.closeErrMsgRegisterUser(),
                //   )
                const SizedBox(
                  height: 20,
                ),
                InputTextCustom(
                  'Nombres  *',
                  hintText: 'Ingresa tu primer nombre',
                  controller: namesCtrl,
                  onChange: (String value) => viewModel.changeFirstName(value),
                  changeFillWith: !viewModel.status.isFirstNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? firstName) =>
                      viewModel.validatorNotEmpty(firstName),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Apellidos  *',
                  hintText: 'Ingresa tu segundo nombre',
                  controller: surnamesCtrl,
                  onChange: (String value) => viewModel.changeSecondName(value),
                  changeFillWith: !viewModel.status.isSecondNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? secondName) =>
                      viewModel.validatorNotEmpty(secondName),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Fecha de nacimiento  *',
                  keyboardType: TextInputType.none,
                  hintText: 'Ingresa tu fecha de nacimiento',
                  controller: viewModel.status.dateBirthCtrl,
                  validator: viewModel.validateBirthday,
                  changeFillWith: !viewModel.status.isDateBirthFieldEmpty,
                  enableInteractiveSelection: false,
                  onTap: () async {
                    final DateTime? newDate = await showDatePicker(
                      locale: const Locale("es", "CO"),
                      context: context,
                      initialDate: dateAllowed,
                      firstDate: DateTime(1900),
                      lastDate: dateAllowed,
                      builder: (BuildContext context, Widget? child) => Theme(
                        data: ThemeData().copyWith(
                          colorScheme: const ColorScheme.light(
                            onPrimary: Colors.black,
                            primary: LdColors.orangePrimary,
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    viewModel.setDateBirth(newDate);
                  },
                ),
                const SizedBox(height: 16),
                // CountryCodePicker(
                //   onChanged: viewModel.changeIndicative,
                //   padding: EdgeInsets.zero,
                //   initialSelection: 'CO',
                //   showCountryOnly: true,
                //   favorite: const <String>['CO'],
                //   textStyle: textTheme.textSmallBlack,
                //   dialogTextStyle: textTheme.textSmallBlack,
                //   searchStyle: textTheme.subtitleBlack,
                //   barrierColor: LdColors.blackBackground.withOpacity(0.7),
                // ),
                InputTextCustom(
                  'Celular  *',
                  hintText: 'Ingresa tu celular',
                  controller: phoneCtrl,
                  contentPadding: const EdgeInsets.only(
                      right: 8, left: 8, top: 8, bottom: 12),
                  maxLength: 13,
                  counterText: '7 - 13 Caracteres   ',
                  onChange: (String value) => viewModel.changePhone(value),
                  changeFillWith: !viewModel.status.isPhoneFieldEmpty,
                  textInputAction: TextInputAction.next,
                  validator: (String? phone) => viewModel.validatePhone(phone),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  pickerCountry: true,
                  onChangeIndicative: viewModel.changeIndicative,
                ),
                const SizedBox(height: 16),
                PrimaryButtonCustom(
                  'Continuar',
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      viewModel.finishRegister(
                        context,
                        dataUserProvider,
                        namesCtrl.text,
                        surnamesCtrl.text,
                        viewModel.status.dateBirth,
                        phoneCtrl.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Row checkRowValidation(String title, {required bool? value}) {
//   return Row(
//     children: <Widget>[
//       SizedBox(
//         height: 24,
//         child: Checkbox(
//           activeColor: LdColors.orangePrimary,
//           value: value,
//           onChanged: (_) {},
//         ),
//       ),
//       Flexible(
//         child: Text(title),
//       ),
//     ],
//   );
// }
}

// CountryCodePicker(
// onChanged: viewModel.changeIndicative,
// padding: EdgeInsets.zero,
// showDropDownButton: true,
// initialSelection: 'CO',
// showOnlyCountryWhenClosed: true,
// favorite: const <String>['CO'],
// alignLeft: true,
// textStyle: textTheme.textBlack,
// dialogTextStyle: textTheme.subtitleBlack,
// searchStyle: textTheme.subtitleBlack,
// barrierColor: LdColors.blackBackground.withOpacity(0.7),
// )
