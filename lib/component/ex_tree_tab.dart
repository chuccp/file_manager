import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class ExTreeTable extends StatelessWidget {
  const ExTreeTable({super.key, this.body});

  final IndexedWidgetBuilder? body;

  @override
  Widget build(BuildContext context) {
    List<Node> nodes = <Node>[
      const Node(
          label: '全部目录',
          key: 'docs',
          icon: Icons.folder,
          expanded: false,
          children: [Node(label: '我的空间', key: 'docs001', icon: Icons.folder)])
    ];
    TreeViewController treeViewController = TreeViewController(children: nodes);

    var list = <Widget>[
      SizedBox(
          width: 160,
          child: TreeView(
            controller: treeViewController,
          ))
    ];
    if (body != null) {
      list.add(const VerticalDivider(
        width: 0,
        indent: 0,
        endIndent: 0,
        color: Colors.black12,
      ));
      list.add(Expanded(
        child: Builder(
          builder: (ctx)=>body!(ctx,0),
        ),
      ));
    }
    return Row(
      children: list,
    );
  }
}
