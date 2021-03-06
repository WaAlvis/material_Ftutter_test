import 'package:bogota_app/commons/idt_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class LoginButtons extends StatelessWidget {

  Function(int)? login;
  VoidCallback? logout;
  VoidCallback? alert;


  LoginButtons({this.login,this.logout, this.alert});

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.white,
      height: 60,
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              color: Colors.white,
              child: Image(image: AssetImage(IdtAssets.facebook)),
              width: 40,
              height: 40,
            ),
            // onTap: _userData != null ? viewModel.logOut : viewModel.login(),

            onTap:()=> login!(1),
          ),
          SizedBox(
            width: 8,
          ),
          InkWell(
            child: Container(
              color: Colors.white,
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage(IdtAssets.google),
              ),
            ),
            onTap:()=> 2 == null ? logout : login!(2),
          ),
          SizedBox(
            width: 8,
          ),
          isIOS?
          Container(
            color: Colors.white,
            width: 50,
            height: 50,
            child: Image(
              image: AssetImage(IdtAssets.apple),
            ),
          ):
              SizedBox.shrink()
        ],
      ),
    );
  }
}
