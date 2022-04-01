part of '../../../home_view.dart';

class CardWalletConnect extends StatelessWidget {
  const CardWalletConnect({
    Key? key,
    required this.textTheme,
    required this.connected,
    required this.onTap,
    this.address,
  }) : super(key: key);

  final TextTheme textTheme;
  final bool connected;
  final VoidCallback onTap;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !connected ? onTap : null,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: LdColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: LdColors.blackDark.withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: 0.2,
              offset: const Offset(0, 0.5),
            )
          ],
        ),
        margin: const EdgeInsets.all(10),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            const CircleDecoration(quarter: 1, color: LdColors.orangePrimary),
            const CircleDecoration(quarter: 2, color: LdColors.orangePrimary),
            const CircleDecoration(quarter: 3, color: LdColors.orangePrimary),
            const CircleDecoration(quarter: 4, color: LdColors.orangePrimary),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          /* const Icon(
                            Icons.account_balance_wallet,
                            color: LdColors.orangePrimary,
                          ), */
                          SvgPicture.asset(
                            LdAssets.dlyIcon,
                            height: 30,
                            fit: BoxFit.scaleDown,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            connected
                                ? 'Wallet MiDaily conectada'
                                : 'Conectar Wallet MiDaily',
                            style: textTheme.textSmallBlack,
                          ),
                        ],
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 5,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          connected ? Icons.link_off : Icons.link,
                          color: LdColors.orangePrimary,
                        ),
                        tooltip: connected ? 'Desconectar' : 'Conectar',
                        onPressed: connected ? onTap : null,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.zero,
                    child: Divider(
                      color: LdColors.gray,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        connected
                            ? '¡Ya tienes tu wallet conectada!'
                            : 'Tienes tu wallet desconectada',
                        style: textTheme.textBlack,
                      ),
                      if (!connected)
                        Text(
                          'Conecta tu wallet de MiDaily para poder disfrutar LocalDaily en su totalidad.',
                          style: textTheme.textSmallBlack.copyWith(
                            color: LdColors.gray,
                          ),
                        )
                    ],
                  ),
                  if (connected)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        color: LdColors.orangePrimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          address ?? '',
                          style: textTheme.textSmallBlack.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
