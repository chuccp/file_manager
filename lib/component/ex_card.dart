import 'package:flutter/material.dart';

class ExCard extends StatelessWidget {
  const ExCard({super.key, this.width, this.height, this.child});
  final Widget? child;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              width: width,
              height: height,
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Card(
                child: child,
              )),
        ));
  }
}