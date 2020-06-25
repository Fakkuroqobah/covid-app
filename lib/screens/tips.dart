import 'package:covid/utils/appStyle.dart';
import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primary,
      appBar: AppBar(
        title: Text("Tips", style: TextStyle(
          fontFamily: 'ibm-regular'
        )),
        elevation: 0.0,
        backgroundColor: AppStyle.primary
      ),
      body: ListView(
        children: <Widget>[
          Image.asset("assets/images/tips.jpg")
        ],
      ),
    );
  }
}