import 'package:file_manager/component/ex_load.dart';
import 'package:file_manager/file/file_user_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import '../component/ex_tree_tab.dart';
import 'file_path_setting.dart';

class FileSettingPage extends StatelessWidget {
  const FileSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Node>? nodes = <Node>[
      const Node(
        label: '路径设置',
        key: 'path',
        icon: Icons.account_tree,
        expanded: false,
      ),
      const Node(
        label: '用户管理',
        key: 'user',
        icon: Icons.account_circle,
        expanded: false,
      )
    ];

    return Card(
        child: ExTreeTable(
      nodes: nodes,
      selectedKey: "user",
      body: (_, key) {
        if (key == "path") {
          return const FilePathSetting();
        }
        if (key == "user") {
          return const FileUserSetting();
        }
        return const FilePathSetting();
      },
    ));
  }
}
