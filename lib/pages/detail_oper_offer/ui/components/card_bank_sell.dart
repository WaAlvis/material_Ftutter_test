part of '../detail_oper_offer_view.dart';

class CardBankSell extends StatefulWidget {
  const CardBankSell({Key? key, required this.textTheme, required this.item})
      : super(key: key);
  final TextTheme textTheme;
  final dynamic item;

  @override
  State<CardBankSell> createState() => _CardBankSellState();
}

class _CardBankSellState extends State<CardBankSell> {
  List<DetailBankSell> banks = <DetailBankSell>[];

  @override
  void initState() {
    _banks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LdColors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          const Center(
              child: Text(
            'Entidades donde recibirás el pago',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: banks,
            ),
          ),
        ],
      ),
    );
  }

  void _banks() {
    banks.add(DetailBankSell(bank: 'Bancolombia'));
    banks.add(DetailBankSell(bank: 'Nequi'));
    banks.add(DetailBankSell(bank: 'Davivienda'));
    setState(() {});
  }
}

class DetailBankSell extends StatelessWidget {
  const DetailBankSell({
    Key? key,
    required this.bank,
  }) : super(key: key);
  final String bank;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 20,
        ),
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {}, // Por si es necesario revisar el detalle del banco
              child: Text(
                bank,
                style: const TextStyle(fontSize: 18, color: LdColors.black),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ],
    );
  }
}
