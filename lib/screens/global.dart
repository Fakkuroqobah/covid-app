import 'package:covid/model/m_global.dart';
import 'package:covid/utils/appStyle.dart';
import 'package:covid/utils/number.dart';
import 'package:covid/widgets/buildCard.dart';
import 'package:flutter/material.dart';

class Global extends StatelessWidget {
  final GlobalModel data;
  final String dateIndo;

  const Global({Key key, this.data, this.dateIndo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Update terakhir: $dateIndo", style: TextStyle(
              color: Colors.white,
              fontSize: 14.0
            ))
          ],
        ),

        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            BuildCard(
              title: "Total Positif",
              total: number(data.confirmed.value),
              color: AppStyle.warning,
              img: "assets/images/sad.png"
            )
          ],
        ),

        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            BuildCard(
              title: "Total Sembuh",
              total: number(data.recovered.value),
              color: AppStyle.success,
              img: "assets/images/happy.png"
            ),

            SizedBox(width: 10.0),
            BuildCard(
              title: "Total Meninggal",
              total: number(data.deaths.value),
              color: AppStyle.danger,
              img: "assets/images/crying.png"
            ),
          ],
        ),
      ],
    );
  }
}