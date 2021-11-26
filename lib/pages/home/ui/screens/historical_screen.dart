import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../app_theme.dart';

class HistoricalScreen extends StatefulWidget {


  const HistoricalScreen();

  @override
  _HistoricalScreenState createState() => _HistoricalScreenState();
}

class _HistoricalScreenState extends State<HistoricalScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Center(
        child: const Text('Historial page'),
      ),
    );
  }
}
