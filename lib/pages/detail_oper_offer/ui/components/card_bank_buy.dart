part of '../detail_oper_offer_view.dart';

class CardBankBuy extends StatefulWidget {
  const CardBankBuy({
    Key? key,
    required this.textTheme,
    required this.isBuy,
    required this.state,
    required this.viewModel,
  }) : super(key: key);
  final TextTheme textTheme;
  final bool isBuy;
  final String state;
  final DetailOperOfferViewModel viewModel;

  @override
  State<CardBankBuy> createState() => _CardBankBuyState();
}

class _CardBankBuyState extends State<CardBankBuy> {
  List<CardBankBuyDetails> list = <CardBankBuyDetails>[];
  bool isEmpty = true;
  @override
  void initState() {
    // TODO: traer informacion de bancos
    widget.viewModel.status.banks.asMap().forEach((index, bank) {
      if (bank.description.isNotEmpty) {
        isEmpty = false;
      }
      // print('**** $index  &&&& ${bank.description}');
      // print(
      //     '${bank.description} posicion ${widget.viewModel.status.listAccountTypes.isEmpty}');

      list.add(
        CardBankBuyDetails(
          item: widget.viewModel.status.item,
          state: widget.state,
          bank: bank.description,
          docType: widget.viewModel.status.docsType![index].description,
          accountNumber: widget.viewModel.status.item!
              .advertisementPayAccount![index].accountNumber,
          userName: widget.viewModel.status.item!
              .advertisementPayAccount![index].titularUserName,
          documentNumber: widget.viewModel.status.item!
              .advertisementPayAccount![index].documentNumber,
          acountType: widget.viewModel.status.listAccountTypes.isEmpty
              ? ''
              : widget.viewModel.status.listAccountTypes[index].description,
        ),
      );
    });

    // setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        if (isEmpty)
          const Text('')
        else
          Text(
            widget.isBuy
                ? 'Entidades donde puedes pagar'
                : 'Entidades donde recibirás el pago',
            style: textTheme.textBlack.copyWith(fontSize: 18),
          ),
        const SizedBox(
          height: 32,
        ),
        Container(
          decoration: BoxDecoration(
            // color: LdColors.green.withOp÷acity(0.08),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: list,
          ),
        ),
      ],
    );
  }
}

class CardBankBuyDetails extends StatefulWidget {
  const CardBankBuyDetails(
      {Key? key,
      required this.item,
      required this.state,
      required this.bank,
      required this.docType,
      required this.accountNumber,
      required this.userName,
      required this.documentNumber,
      required this.acountType})
      : super(key: key);

  final dynamic item;
  final String state;
  final String bank;
  final String docType;
  final String accountNumber;
  final String userName;
  final String documentNumber;
  final String acountType;

  @override
  State<CardBankBuyDetails> createState() => _CardBankBuyDetailsState();
}

class _CardBankBuyDetailsState extends State<CardBankBuyDetails> {
  // double _height = 168;
  bool isExpanded = false;
  List<Widget> listRow = [];
  Color _color = LdColors.orangePrimary;

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

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            color: _color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.bank,
                    style: textTheme.textBlack
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '# cuenta',
                    style: textTheme.textBlack.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 143,
                  ),
                  Text(
                    'Tipo',
                    style: textTheme.textBlack.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.accountNumber,
                    style: textTheme.textBlack
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 143,
                  ),
                  Text(
                    widget.acountType,
                    style: textTheme.textBlack
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(children: listRow),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: FloatingActionButton(
                  heroTag: '${widget.item.toString()}',
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    // _height = isExpanded ? 318 : 168;
                    isExpanded = !isExpanded;
                    setState(() {});
                    _getInfo(widget.item, textTheme, isExpanded, widget.docType,
                        widget.userName, widget.documentNumber);
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
        ),
      ],
    );
  }

  void _getInfo(item, TextTheme textTheme, bool isExpanded, String docType,
      String userName, String documentNumber) {
    listRow = [];
    if (isExpanded) {
      listRow.add(
        const SizedBox(height: 16),
      );
      listRow.add(
        Container(
          height: 1,
          width: 311,
          color: LdColors.orangePrimary,
        ),
      );
      listRow.add(
        const SizedBox(height: 16),
      );
      listRow.add(
        Row(
          children: <Widget>[
            const SizedBox(
              width: 16,
            ),
            Text(
              'Tipo de documento',
              style: textTheme.textBlack.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              width: 77,
            ),
            Text(
              '# documento',
              style: textTheme.textBlack.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
      listRow.add(
        const SizedBox(height: 8),
      );
      listRow.add(
        Row(
          children: <Widget>[
            const SizedBox(
              width: 16,
            ),
            Text(
              docType,
              style: textTheme.textBlack
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 44,
            ),
            Text(
              documentNumber,
              style: textTheme.textBlack
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
      listRow.add(
        const SizedBox(height: 21),
      );
      listRow.add(
        Row(
          children: <Widget>[
            const SizedBox(
              width: 16,
            ),
            Text(
              'Titular',
              style: textTheme.textBlack.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
      listRow.add(
        const SizedBox(height: 8),
      );
      listRow.add(
        Row(
          children: <Widget>[
            const SizedBox(
              width: 16,
            ),
            Text(
              userName,
              style: textTheme.textBlack
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
      listRow.add(
        const SizedBox(height: 6),
      );
    }
  }
}
