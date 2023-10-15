import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

typedef KeyWidgetBuilder = Widget Function(BuildContext context, String index);

class ExTreeTable extends StatefulWidget {
  const ExTreeTable({super.key, this.body, this.nodes, this.selectedKey});

  final KeyWidgetBuilder? body;

  final List<Node>? nodes;

  final String? selectedKey;

  @override
  State<StatefulWidget> createState() => _ExTreeTableState();
}

class _ExTreeTableState extends State<ExTreeTable> {
  String _selectedKey = "";

  void _onItemTapped(String key) {
    setState(() {
      _selectedKey = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? selectedKey = widget.selectedKey;
    if (_selectedKey.isNotEmpty) {
      selectedKey = _selectedKey;
    }
    selectedKey ??= "";

    List<Node>? nodes = <Node>[];
    if (widget.nodes != null && widget.nodes!.isNotEmpty) {
      nodes = widget.nodes;
    }
    TreeViewController treeViewController = TreeViewController(children: nodes!, selectedKey: selectedKey);
    var list = <Widget>[
      SizedBox(
          width: 160,
          child: TreeView(
            onNodeTap: (key) => {_onItemTapped(key)},
            controller: treeViewController,
          ))
    ];
    if (widget.body != null) {
      list.add(const VerticalDivider(
        width: 0,
        indent: 0,
        endIndent: 0,
        color: Colors.black12,
      ));
      list.add(Expanded(
        child:Align(alignment:Alignment.topLeft,child: Builder(
          builder: (ctx) => widget.body!(ctx, selectedKey!),
        ),),
      ));
    }
    return Row(
      children: list,
    );
  }
}
