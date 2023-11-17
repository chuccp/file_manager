import 'package:flutter/material.dart';

class ExButtonGroup extends StatelessWidget {
   ExButtonGroup({super.key,required this.children});

  List<Widget> children;

  @override
  Widget build(BuildContext context) {

    var childrenView = <Widget>[];
    childrenView.add(const Spacer(
      flex: 1,
    ));

    for (var element in children) {
      childrenView.add( Expanded(
        flex: 3,
        child: element,
      ));
      childrenView.add(const Spacer(
        flex: 1,
      ));
    }
    return Expanded(child: Flex(direction: Axis.horizontal, children:childrenView));
  }
}
