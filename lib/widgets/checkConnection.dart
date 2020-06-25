import 'package:flutter/material.dart';

class CheckConnection extends StatelessWidget {
  final bool connected;
  final Widget child;

  const CheckConnection(this.connected, this.child);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          height: 32.0,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: !connected ? AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Periksa koneksi anda', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 12.0,
                    height: 12.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ) : Text(""),
        ),
      ],
    );
  }
}