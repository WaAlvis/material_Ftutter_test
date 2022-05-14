part of '../detail_oper_offer_view.dart';

class CardRateUser extends StatelessWidget {
  const CardRateUser({Key? key, required this.viewModel}) : super(key: key);
  final DetailOperOfferViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(8),
      width: 342,
      height: 233,
      decoration: const BoxDecoration(
        color: LdColors.grayState,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Text(
            'Califica al usuario',
            style: textTheme.bodyMedium
                ?.copyWith(color: LdColors.white, fontSize: 24),
          ),
          const SizedBox(
            height: 17,
          ),
          Text(
            'Esto nos ayuda a crear una comunidad confiable.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium
                ?.copyWith(color: LdColors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 28,
          ),
          RatingBar.builder(
            minRating: 1,
            allowHalfRating: true,
            itemCount: 5,
            glowColor: LdColors.white,
            unratedColor: LdColors.white.withOpacity(0.3),
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (BuildContext context, _) => const Icon(
              Icons.star,
              color: LdColors.white,
            ),
            onRatingUpdate: (double rating) {
              // viewModel.status.rateUser = rating;
              viewModel.setRate(rating);
            },
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
