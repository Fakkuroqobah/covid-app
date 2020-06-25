import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  final Color color;
  final String title;
  final String total;
  final String img;

  const BuildCard({Key key, this.color, this.title, this.total, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0)
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(title, style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                )),
                Text(total, style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
                )),
                Text("Orang", style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                )),
              ],
            ),

            Image.asset(img, width: 50.0,)
          ],
        ),
      )
    );
  }
}