
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../entry/file.dart';

typedef RootFileItemCall = Future<List<FileItem>> Function();

typedef PathFileItemCall = Future<List<FileItem>> Function(String key);

class ExTreeFile extends StatefulWidget {
  const ExTreeFile({super.key, this.root, this.path});

  final RootFileItemCall? root;

  final PathFileItemCall? path;

  @override
  State<StatefulWidget> createState() => _ExTreeFileState();
}

class _ExTreeFileState extends State<ExTreeFile> {
  @override
  Widget build(BuildContext context) {
    List<Node>? nodes = <Node>[
      const Node(key: 'C:/', label: 'C:/',icon:Icons.storage,children:[Node(key: 'C:/AAA', label: 'AAA')]),
       const Node(key: 'D:/', label: 'D:/',icon:Icons.storage,children:[Node(key: 'D:/AAA', label: 'AAA')])

    ];
    TreeViewController treeViewController = TreeViewController(children: nodes!);
    var list = <Widget>[
      SizedBox(
          width: 160,
          child: TreeView(
            controller: treeViewController,
          ))
    ];
    return Row(
      children: list,
    );
  }
}
