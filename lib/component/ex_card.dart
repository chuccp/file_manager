import 'package:flutter/material.dart';

class ExCard extends StatelessWidget {
  const ExCard(
      {super.key,
      this.width,
      this.height,
      required this.child,
      this.title,
      this.footer});

  final Widget child;
  final double? width;
  final double? height;
  final String? title;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    if (title != null && title!.isNotEmpty) {
      list.add(ListTile(title: Text(title!!)));
    }
    double vHeight = height==null || height!<110 ? 0:height!-110;
    list.add(SizedBox(height: vHeight,child:child ,));
    if (footer != null) {
      list.add(footer!);
    }
    return Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              width: width,
              height: height,
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Card(
                child: Column(
                  children: list,
                ),
              )),
        ));
  }
}
