part of '../detail_oper_offer_view.dart';

class CardDetailOperOffer extends StatefulWidget {
  const CardDetailOperOffer({
    Key? key,
    required this.textTheme,
    required this.isBuy,
    required this.state,
    required this.item,
    required this.viewModel,
  }) : super(key: key);
  final TextTheme textTheme;
  final bool isBuy;
  final String state;
  final dynamic item;
  final DetailOperOfferViewModel viewModel;

  @override
  State<CardDetailOperOffer> createState() => _CardDetailOperOfferState();
}

class _CardDetailOperOfferState extends State<CardDetailOperOffer> {
  int countStates = 0;
  @override
  void initState() {
    _getState();
    super.initState();
  }

  void _getState() {
    _list.add(
      DetailState(
        state: widget.state,
        isBuy: widget.isBuy,
        item: widget.item,
        isOper: widget.viewModel.status.isOper,
      ),
    );
    print('object Aaaaaaaaaaaaa ${widget.state}');
    switch (widget.state) {
      case 'Cerrado':
        _color = LdColors.blueState;
        countStates = 4;
        break;
      case 'Pagado':
        countStates = 3;
        _color = LdColors.green;
        break;
      case 'Pendiente de pago':
        _color = LdColors.gray;
        countStates = 2;
        break;
      case 'Publicado':
        _color = LdColors.orangePrimary;
        countStates = 1;
        break;
    }
    setState(() {});
  }

  bool isExpanded = false;
  Color _color = LdColors.orangePrimary;
  List<DetailState> _list = [];
  List<DetailState> _list2 = [];

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
                _getStates(countStates);
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

  void _getStates(int countState) {
    if (isExpanded) {
      _list2 = [];
      _list = [];
      _list2.add(DetailState(
        state: 'Cerrado',
        isBuy: widget.isBuy,
        item: widget.item,
        isOper: widget.viewModel.status.isOper,
      ));
      _list2.add(DetailState(
        state: 'Pagado',
        isBuy: widget.isBuy,
        item: widget.item,
        isOper: widget.viewModel.status.isOper,
      ));
      _list2.add(DetailState(
        state: 'Pendiente de pago',
        isBuy: widget.isBuy,
        item: widget.item,
        isOper: widget.viewModel.status.isOper,
      ));
      _list2.add(
        DetailState(
          state: 'Publicado',
          isBuy: widget.isBuy,
          item: widget.item,
          isOper: widget.viewModel.status.isOper,
        ),
      );
      if (countStates == 1) {
        _list.add(_list2[3]);
      } else if (countStates == 2) {
        _list.add(_list2[2]);
        widget.viewModel.status.isOper ? null : _list.add(_list2[3]);
      } else if (countStates == 3) {
        _list.add(_list2[1]);
        _list.add(_list2[2]);
        widget.viewModel.status.isOper ? null : _list.add(_list2[3]);
      } else if (countStates == 4) {
        _list.add(_list2[0]);
        _list.add(_list2[1]);
        _list.add(_list2[2]);
        widget.viewModel.status.isOper ? null : _list.add(_list2[3]);
      }
      setState(() {});
    } else {
      _list = [];
      _list.add(DetailState(
        state: widget.state,
        isBuy: widget.isBuy,
        item: widget.item,
        isOper: widget.viewModel.status.isOper,
      ));
      setState(() {});
    }
  }
}
