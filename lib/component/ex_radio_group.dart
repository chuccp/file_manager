import 'package:flutter/material.dart';

class ExRadioGroup extends StatefulWidget {
  ExRadioGroup(
      {super.key, required this.titles, required this.values, this.controller});

  List<String> titles;
  List<String> values;

  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() => _ExRadioGroupState();
}

class _ExRadioGroupState extends State<ExRadioGroup> {
  String groupValue = "";

  void _updateValue(String val) {
    setState(() {
      groupValue = val;
      if (widget.controller != null) {
        widget.controller?.text = val;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (groupValue.isEmpty) {
      groupValue = widget.values.first;
      widget.controller?.text = groupValue;
    }
    var children = <Widget>[
      for (var i = 0; i < widget.titles.length; i++)
        RadioListTile<String>(
          title: Text(widget.titles.elementAt(i)),
          value: widget.values.elementAt(i),
          groupValue: groupValue,
          onChanged: (value) {
            _updateValue(value!);
          },
        )
    ];
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 200,
          height: 100,
          child: Column(
            children: children,
          ),
        ));
  }
}
