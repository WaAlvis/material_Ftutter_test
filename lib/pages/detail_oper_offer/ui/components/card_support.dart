part of '../detail_oper_offer_view.dart';

class CardSupport extends StatelessWidget {
  const CardSupport({Key? key, required this.textTheme}) : super(key: key);
  final TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(bottom: 53),
      decoration: BoxDecoration(
        color: LdColors.grayText.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.asset(
                  LdAssets.contactOper,
                  height: 38,
                  width: 38,
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        '¿Tienes inquietudes con esta operación?',
                        style: textTheme.textBlack.copyWith(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {}, //Abrir perfil del comprador
                        child: Text(
                          'Contacta a soporte',
                          style: textTheme.bodyMedium?.copyWith(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              color: LdColors.orangePrimary),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
