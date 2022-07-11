part of 'filters_view.dart';

class _FilterMobile extends StatelessWidget {
  const _FilterMobile({Key? key, required this.filtersArguments})
      : super(key: key);
  final FiltersArguments filtersArguments;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final FilterViewModel viewModel = context.watch<FilterViewModel>();
    final ConfigurationProvider configProvider =
        context.read<ConfigurationProvider>();
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body
    const double hAppbar = 100;
    List<String> rangeDly = [
      '[0, 100000]',
      '[100000, 500000]',
      '[500000, 1000000]',
      '[1000000, 2000000]',
      '[2000000, 5000000]',
      '[5000000, 10000000]',
      '[10000000, 999999999]'
    ];
    late ExtraFiltersString jsonFilterString = ExtraFiltersString();
    final index = filtersArguments.getFilters!();

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
          title: 'Filtros',
        ),
        body: Column(
          children: <Widget>[
            const AppbarCircles(hAppbar: hAppbar),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: size.height - hAppbar),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: LdColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(
                          height: 28,
                        ),
                        FormBuilderRadioGroup(
                          initialValue: viewModel.status.range,
                          controlAffinity: ControlAffinity.trailing,
                          valueTransformer: (int? index) {
                            if (index != null && index != -1)
                              jsonFilterString.range = rangeDly[index];
                          },
                          onChanged: (int? index) {
                            viewModel.setRange(index);
                          },
                          orientation: OptionsOrientation.vertical,
                          name: 'range',
                          decoration: InputDecoration(
                            label: Container(
                              height: 70,
                              padding: EdgeInsets.only(bottom: 45),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Cantidad DLYCOP',
                                    style: textTheme.bodyMedium
                                        ?.copyWith(fontSize: 24),
                                  )
                                ],
                              ),
                            ),
                          ),
                          activeColor: LdColors.orangePrimary,
                          options: [
                            FormBuilderFieldOption(
                              value: 0,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Hasta 100.000 DLYCOP',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            FormBuilderFieldOption(
                              value: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '100.000 a 500.000 DLYOP',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            FormBuilderFieldOption(
                              value: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '500.000 a 1.000.000 DLYOP',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            FormBuilderFieldOption(
                              value: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '1.000.000 a 2.000.000 DLYOP',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            FormBuilderFieldOption(
                              value: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '2.000.000 a 5.000.000 DLYOP',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            FormBuilderFieldOption(
                              value: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '5.000.000 a 10.000.000 DLYOP',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            FormBuilderFieldOption(
                              value: 6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Mas de 10.000.000 DLYCOP',
                                    style: textTheme.bodyText2!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (index == 0)
                          FormBuilderRadioGroup(
                            orientation: OptionsOrientation.vertical,
                            controlAffinity: ControlAffinity.trailing,
                            initialValue: viewModel.status.dateExpiry,
                            name: 'dateExpiry',
                            valueTransformer: (int? index) {
                              index != null
                                  ? jsonFilterString.dateExpiry =
                                      viewModel.getDateExpiry(index)
                                  : null;
                            },
                            onChanged: (int? index) {
                              viewModel.setDateExpiry(index);
                            },
                            decoration: InputDecoration(
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('Tiempo de expiración')
                                ],
                              ),
                              // labelText: 'Cantidad DLYCOP',
                              labelStyle:
                                  textTheme.bodyMedium?.copyWith(fontSize: 24),
                            ),
                            activeColor: LdColors.orangePrimary,
                            options: [
                              FormBuilderFieldOption(
                                value: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Menos de 24 horas',
                                      style: textTheme.bodyText2!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'De 24 a 72 horas',
                                      style: textTheme.bodyText2!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Más de 72 horas',
                                      style: textTheme.bodyText2!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (int.parse(index.toString()) > 0)
                          FormBuilderRadioGroup(
                            orientation: OptionsOrientation.vertical,
                            controlAffinity: ControlAffinity.trailing,
                            initialValue: viewModel.status.dateExpiry,
                            name: 'dateExpiry',
                            valueTransformer: (int? index) {
                              index != null
                                  ? jsonFilterString.dateExpiry =
                                      viewModel.getDateExpiryOper(index)
                                  : null;
                            },
                            onChanged: (int? index) {
                              viewModel.setDateExpiry(index);
                            },
                            decoration: InputDecoration(
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('Tiempo de operación')
                                ],
                              ),
                              // labelText: 'Cantidad DLYCOP',
                              labelStyle:
                                  textTheme.bodyMedium?.copyWith(fontSize: 24),
                            ),
                            activeColor: LdColors.orangePrimary,
                            options: [
                              FormBuilderFieldOption(
                                value: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Menos de 4 horas',
                                      style: textTheme.bodyText2!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'De 4 a 8 horas',
                                      style: textTheme.bodyText2!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Más de 8 horas',
                                      style: textTheme.bodyText2!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (int.parse(index.toString()) > 0)
                          FormBuilderRadioGroup(
                            orientation: OptionsOrientation.vertical,
                            controlAffinity: ControlAffinity.trailing,
                            initialValue: viewModel.status.status,
                            name: 'status',
                            valueTransformer: (int? index) {
                              if (index != null)
                                jsonFilterString.status = index.toString();
                            },
                            onChanged: (int? index) {
                              viewModel.setStatus(index);
                            },
                            decoration: InputDecoration(
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[Text('Estado')],
                              ),
                              // labelText: 'Cantidad DLYCOP',
                              labelStyle:
                                  textTheme.bodyMedium?.copyWith(fontSize: 24),
                            ),
                            activeColor: LdColors.orangePrimary,
                            options: [
                              FormBuilderFieldOption(
                                value: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 24,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                        color: LdColors.orangePrimary,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            alignment: Alignment.centerLeft,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Publicado',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: LdColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 24,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                        color: LdColors.grayState,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            alignment: Alignment.centerLeft,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Pendiente',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: LdColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 24,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                        color: LdColors.green,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            alignment: Alignment.centerLeft,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Pagado',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: LdColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 24,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                        color: LdColors.blueState,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            alignment: Alignment.centerLeft,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Cerrado',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: LdColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FormBuilderFieldOption(
                                value: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 24,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                        color: LdColors.redError,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            alignment: Alignment.centerLeft,
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Disputa',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: LdColors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // FormBuilderFieldOption(
                              //   value: 4,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: <Widget>[
                              //       Container(
                              //         height: 24,
                              //         width: 130,
                              //         decoration: const BoxDecoration(
                              //           color: LdColors.yellowDark,
                              //           borderRadius: BorderRadius.all(
                              //             Radius.circular(4),
                              //           ),
                              //         ),
                              //         child: Flex(
                              //           direction: Axis.horizontal,
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: <Widget>[
                              //             FittedBox(
                              //               alignment: Alignment.centerLeft,
                              //               fit: BoxFit.scaleDown,
                              //               child: Text(
                              //                 'Soporte',
                              //                 textAlign: TextAlign.center,
                              //                 style: TextStyle(
                              //                   color: LdColors.white,
                              //                   fontSize: 14,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        // Container(
                        //   padding: EdgeInsets.all(15),
                        //   child: CustomSliderRange(),
                        // ),
                        if (index == 0)
                          GestureDetector(
                            onTap: () {
                              _formKey.currentState!.save();

                              viewModel.getDialogBanks(context);
                            },
                            child: FormBuilderTextField(
                              enabled: false,
                              name: 'bank',
                              initialValue: viewModel.status.banks == null
                                  ? null
                                  : viewModel.status.banks.toString(),
                              valueTransformer: (String? banks) {
                                jsonFilterString.bank =
                                    json.encode(viewModel.setBankApi(banks!));
                              },
                              decoration: InputDecoration(
                                label: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Text('Selecciona tu entidad'),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        PrimaryButtonCustom(
                          'Borrar',
                          onPressed: () {
                            try {
                              _formKey.currentState?.reset();
                              viewModel.clearFilters();
                              jsonFilterString = ExtraFiltersString();
                              filtersArguments.clearFilters!();
                            } catch (e) {
                              print(e);
                            }
                          },
                          colorButton: LdColors.white,
                          colorText: LdColors.orangePrimary,
                          colorTextBorder: LdColors.orangePrimary,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        PrimaryButtonCustom(
                          'Filtrar',
                          onPressed: () {
                            _formKey.currentState!.save();

                            late ExtraFilters jsonFilter =
                                ExtraFilters.fromJson(
                                    _formKey.currentState!.value);

                            filtersArguments.setFilters!(
                              jsonFilter,
                              jsonFilterString.toJson().toString(),
                            );

                            viewModel.closeDialog(context);
                            // viewModel.goToHome(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
