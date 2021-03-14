import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class IdtMenuFilter extends StatelessWidget {

  final VoidCallback closeMenu;
  final VoidCallback goFilters;
  final List listItems;
  final List filter1;
  final List filter2;
  final List filter3;
  final Function(int, int) tapButton;

  IdtMenuFilter({
    required this.closeMenu,
    required this.listItems,
    required this.goFilters,
    required this.filter1,
    required this.filter2,
    required this.filter3,
    required this.tapButton,
  });

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 168),
      color: IdtColors.white.withOpacity(0.95),
      child: Container(
        color: IdtColors.transparent,
        height: double.infinity,
        child: _buildBody(textTheme)
      ),
    );
  }

  SingleChildScrollView _buildBody(TextTheme textTheme) {

    Widget _filter (Color color, List<Color> gradient, String title, int id){

      final styleApp =  StylesMethodsApp().decorarStyle(
        gradient,
        15,
        Alignment.bottomCenter,
        Alignment.topCenter
      );

      final styleAppWhite = BoxDecoration(color: IdtColors.white);

      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: textTheme.subTitleBlack.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ListView.builder(
              itemCount: listItems.length,
              itemExtent: 90,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(3),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color:
                              id == 1 ? filter1[index] ? color : IdtColors.grayBtn

                              : id == 2 ? filter2[index] ? color : IdtColors.grayBtn

                              : id == 3 ? filter3[index] ? color : IdtColors.grayBtn

                              : IdtColors.grayBtn,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 100.0,
                          minWidth: 20,
                          minHeight: 20.0,
                          maxHeight: 40
                        ),
                        decoration:
                          id == 1 ? filter1[index] ? styleApp : styleAppWhite

                          : id == 2 ? filter2[index] ? styleApp : styleAppWhite

                          : id == 3 ? filter3[index] ? styleApp : styleAppWhite

                          : null,
                        alignment: Alignment.center,
                        child: Text(
                          'Filtro 1',
                          textAlign: TextAlign.center,
                          style: textTheme.textButtomWhite.copyWith(
                            color:
                              id == 1 ? filter1[index] ? null : IdtColors.black.withOpacity(0.8)

                              : id == 2 ? filter2[index] ? null : IdtColors.black.withOpacity(0.8)

                              : id == 3 ? filter3[index] ? null : IdtColors.black.withOpacity(0.8)

                              : null,
                          ),
                        )
                      ),
                      onPressed: () => tapButton(index, id),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      );
    }


    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: IdtColors.orange,
                size: 35,
              ),
              onPressed: closeMenu
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              _filter(IdtColors.orange, IdtGradients.orange, 'Busqueda específica', 1),
              _filter(IdtColors.blue, IdtGradients.blue, 'Busqueda por zona', 2),
              _filter(IdtColors.green, IdtGradients.green, 'Descubre Bogotá', 3),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: IdtColors.blue, width: 1),
                    borderRadius: BorderRadius.circular(80.0)
                  ),
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 250.0,
                      minWidth: 180,
                      minHeight: 50.0,
                      maxHeight: 50
                    ),
                    decoration: StylesMethodsApp().decorarStyle(
                      IdtGradients.blue,
                      30,
                      Alignment.bottomCenter,
                      Alignment.topCenter
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Aplicar',
                      textAlign: TextAlign.center,
                      style: textTheme.textButtomWhite.copyWith(
                        fontSize: 18
                      ),
                    )
                  ),
                  onPressed: closeMenu,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}