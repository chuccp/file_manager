import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import '../component/ex_tree_tab.dart';

class FileTransferView extends StatelessWidget {
  const FileTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Node> nodes = <Node>[
      const Node(
        label: '上传中',
        key: 'upload',
        icon: Icons.account_tree,
        expanded: false,
      ),
      const Node(
        label: '已完成',
        key: 'finish',
        icon: Icons.account_circle,
        expanded: false,
      )
    ];

    return Card(
        child: ExTreeTable(
            selectedKey: "upload",
            nodes: nodes,
            body: (content, key) {
              return const FileTransferListView();
            }));
  }
}

class FileTransferListView extends StatelessWidget {
  const FileTransferListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];
    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: entries.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0,),
        itemBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 50,
            child: Align(
                alignment: Alignment.centerLeft, child: ProcessView()),
          );
        });
  }
}

class ProcessView extends StatelessWidget {
  const ProcessView({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap:(){}, child:const Row(
      children: [
        Icon(Icons.file_copy),
        SizedBox(
            width: 120,
            child: Align(
                child: Column(
              children: [
                SizedBox(width: 120, child: Text("测试")),
                SizedBox(width: 120, child: Text("100GB/1000GB")),
              ],
            ))),
        SizedBox(width: 120, child: Text("23:12:24")),
        SizedBox(
            width: 120,
            child: Column(
              children: [
                LinearProgressIndicator(
                  minHeight:10,
                  backgroundColor: Colors.amber,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                    semanticsLabel:"10%",
                    semanticsValue:"10%"
                ),
                Text("23:12:24")
              ],
            )),
            SizedBox(
            width: 120,
                child:ListTile(title:Text("取消")))
      ],
    ));
  }
}
