import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/data.dart';
import 'package:localdaily/widgets/primary_button.dart';

class MyOfferts extends StatelessWidget {
  const MyOfferts({
    required this.viewModel,
    required this.textTheme,
    required this.itemsBuyers,
    required this.itemsSellers,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final List<Data> itemsBuyers;
  final List<Data> itemsSellers;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LdColors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: LdColors.blackBackground,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset(
                      LdAssets.logo,
                      width: 150,
                    ),
                    IconButton(
                      onPressed: () => viewModel.goLogin(context),
                      icon: const Icon(
                        Icons.account_circle,
                        color: LdColors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.asset(LdAssets.noOffertForSale),
                const SizedBox(
                  height: 12,
                ),
                const Text('Aun no tienes ofertas de venta'),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Crea tu primera oferta y vuelve aqui para hacerle seguimineto',
                  textAlign: TextAlign.center,
                ),
                PrimaryButtonCustom(
                  'Crear oferta de venta',
                  onPressed: () => viewModel.goCreateOffertSale(context),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
