import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        color: Color(0xffFF5959),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Center(child: Text("Maaf, Terjadi kesalahan", style: TextStyle(
        color: Colors.white,
        fontSize: 18.0
      ))),
    );
  }
}