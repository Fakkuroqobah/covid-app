import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1f2f6),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff7d79a3),
              Colors.indigo,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              buildMenu("Tips", EvaIcons.shieldOutline, "tips"),
              buildMenu("Tentang", EvaIcons.infoOutline, "about"),

              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: OutlineButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Keep Healthy", style: TextStyle(fontSize: 18)),
                  ),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  onPressed: () {},
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                ),
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildMenu(String title, IconData icon, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0, left: 24.0, right: 24.0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, name),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.white),
            SizedBox(width: 10.0),
            Text(title, style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            )),
          ],
        ),
      ),
    );
  }
}