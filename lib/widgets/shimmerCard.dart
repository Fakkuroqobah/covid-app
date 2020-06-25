import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.white60,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildLoad()),
            ],
          ),

          SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Expanded(child: buildLoad()),
              SizedBox(height: 14.0),
              Expanded(child: buildLoad()),
            ],
          ),
        ],
      ),
    );
  }

  Container buildLoad() {
    return Container(
      height: 80.0,
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
    );
  }
}