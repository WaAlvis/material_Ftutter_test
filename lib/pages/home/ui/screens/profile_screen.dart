import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app_theme.dart';

class ProfileScreen extends StatefulWidget {


  const ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: Text('profile'),
          centerTitle: true,
          elevation: 0,
          leading: const SizedBox.shrink()),
      body: Center(
        child: Text('profile'),
      ),
    );
  }
}
