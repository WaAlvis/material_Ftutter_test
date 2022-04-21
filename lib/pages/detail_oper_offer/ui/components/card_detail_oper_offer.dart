part of '../detail_oper_offer_view.dart';

class CardDetailOperOffer extends StatefulWidget {
  const CardDetailOperOffer({
    Key? key,
    required this.textTheme,
    required this.isBuy,
    required this.state,
    required this.item,
  }) : super(key: key);
  final TextTheme textTheme;
  final bool isBuy;
  final String state;
  final dynamic item;

  @override
  State<CardDetailOperOffer> createState() => _CardDetailOperOfferState();
}

class _CardDetailOperOfferState extends State<CardDetailOperOffer> {
  @override
  void initState() {
    _getState();
    super.initState();
  }

  void _getState() {
    switch (widget.state) {
      case 'Cerrado':
        _color = LdColors.blueState;
        break;
      case 'Pagado':
        _color = LdColors.green;
        break;
      case 'Pendiente de pago':
        _color = LdColors.gray;
        break;
      case 'Publicado':
        _color = LdColors.orangePrimary;
        break;
    }
  }

  bool isExpanded = false;
  Color _color = LdColors.orangePrimary;
  List<DetailState> _list = [
    DetailState(
      state: 'Pendiente de pago',
      isBuy: true,
      item: 'item',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      curve: Curves.decelerate,
      decoration: BoxDecoration(
        color: _color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _list,
            ),
          ),
          Center(
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                isExpanded = !isExpanded;
                _getStates();
              },
              child: Icon(
                !isExpanded
                    ? Icons.arrow_circle_down_outlined
                    : Icons.arrow_circle_up_outlined,
                color: _color,
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getStates() {
    if (isExpanded) {
      _list = [];
      // _list.add(DetailState(
      //   state: 'Cerrado',
      //   isBuy: true,
      //   item: 'item2',
      // ));
      // _list.add(DetailState(
      //   state: 'Pagado',
      //   isBuy: true,
      //   item: 'item2',
      // ));
      _list.add(DetailState(
        state: 'Pendiente de pago',
        isBuy: true,
        item: 'item2',
      ));
      _list.add(DetailState(
        state: 'Publicado',
        isBuy: true,
        item: 'item2',
      ));

      setState(() {});
    } else {
      _list = [];
      _list.add(DetailState(
        state: 'Pendiente de pago',
        isBuy: true,
        item: 'item2',
      ));
      setState(() {});
    }
  }
}
