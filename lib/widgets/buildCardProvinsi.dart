import 'package:covid/utils/appStyle.dart';
import 'package:flutter/material.dart';

class BuildCardProvinsi extends StatelessWidget {
  final String provinsi;
  final int confirmed, recovered, deaths;

  const BuildCardProvinsi({Key key, this.provinsi, this.confirmed, this.recovered, this.deaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 35.0,
            decoration: BoxDecoration(
              color: AppStyle.secondary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(provinsi, style: TextStyle(
                    color: Colors.white,
                    fontFamily: "ibm-medium"
                  )),
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              buildCard(
                title: "Positif",
                color: AppStyle.warning,
                border: BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                total: confirmed.toString()
              ),
              buildCard(
                title: "Sembuh",
                color: AppStyle.success,
                total: recovered.toString()
              ),
              buildCard(
                title: "Meninggal",
                color: AppStyle.danger,
                border: BorderRadius.only(bottomRight: Radius.circular(8.0)),
                total: deaths.toString()
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded buildCard({String title, Color color, BorderRadiusGeometry border, String total}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: border
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title, style: TextStyle(
                color: Colors.white,
                fontFamily: "ibm-medium"
              )),

              Text(total, style: TextStyle(
                color: Colors.white,
                fontFamily: "ibm-regular"
              )),
            ],
          ),
        ),
      )
    );
  }
}