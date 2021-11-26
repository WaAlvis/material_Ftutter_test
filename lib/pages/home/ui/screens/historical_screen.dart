import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mi_daily/commons/dly_colors.dart';
import 'package:mi_daily/commons/dly_icons.dart';
import 'package:mi_daily/generated/l10n.dart';

import '../../../../app_theme.dart';

class HistoricalScreen extends StatefulWidget {

  final VoidCallback goDetail;
  final VoidCallback goFilters;
  final List<List<dynamic>> filters;
  final Function(int) deleteFilter;
  final Function(List<List<dynamic>>) translateFilter;

  const HistoricalScreen(this.goDetail, this.goFilters, this.filters, this.deleteFilter, this.translateFilter);

  @override
  _HistoricalScreenState createState() => _HistoricalScreenState();
}

class _HistoricalScreenState extends State<HistoricalScreen> {

  @override
  void initState() { 
    widget.translateFilter(widget.filters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final I18n i18n = I18n.current;

    Widget cardHistorical(int index) {

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.only(right: 25),
        decoration: const BoxDecoration(
          color: DlyColors.grayBg,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: DlyColors.white
            )
          ),
        ),
        child: InkWell(
          onTap: widget.goDetail,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 4.0),
                    Text(
                      i18n.moveDlyAction,
                      style: textTheme.subtitleWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      i18n.fromTo('Disponible', 'wallets'),
                      style: textTheme.textGray.copyWith(
                        fontSize: 13
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          DlyIcons.dly,
                          color: index % 2 == 0 ? DlyColors.green :
                            index % 3 == 0 ? DlyColors.red : DlyColors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '125.000.000',
                          style: textTheme.titleWhite.copyWith(
                            fontSize: 20,
                            color: index % 2 == 0 ? DlyColors.green :
                              index % 3 == 0 ? DlyColors.red : DlyColors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: DlyColors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: DlyColors.grayBg,
            appBar: AppBar(
              title: Text(i18n.historyTitle),
              centerTitle: true,
              elevation: 0,
              backgroundColor: DlyColors.black,
              leading: const SizedBox.shrink(),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(DlyIcons.filter),
                  tooltip: i18n.filterIcon,
                  onPressed: widget.goFilters,
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                if (widget.filters.isNotEmpty) Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          '${i18n.filterIcon}: ',
                          style: textTheme.labelWhite,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ListView.builder(
                            // controller: _controller,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            itemCount: widget.filters.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 12),
                                child: InputChip(
                                  label: Text(
                                    widget.filters[index][0] as String,
                                    style: textTheme.labelBlack,
                                  ),
                                  elevation: 1,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  backgroundColor: DlyColors.yellow,
                                  shadowColor: DlyColors.yellow,
                                  deleteIcon: const CircleAvatar(
                                    backgroundColor: DlyColors.grayBg,
                                    child: Icon(
                                      Icons.close,
                                      color: DlyColors.yellow,
                                      size: 16,
                                    ),
                                  ),
                                  onPressed: () {},
                                  onDeleted: () => widget.deleteFilter(index),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ) else const SizedBox.shrink(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      //keyRefresh.currentState?.show(atTop: false);
                      await Future<Duration>.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      // controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: 12,
                      itemBuilder: (BuildContext context, int index) {
                        return cardHistorical(index);
                      },
                    )
                  ),
                ),
              ],
            )
          ),
          // filters
        ],
      ),
    );
  }
}