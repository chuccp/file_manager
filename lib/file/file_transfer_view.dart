import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:provider/provider.dart';
import '../component/ex_tree_tab.dart';
import 'file_mange.dart';

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


    var items = Provider.of<FilePageDelegate>(context).progresses;

    var children = [for(var item in items)  ProcessView(title:item.name!,) ];

    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: children.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 0,
            ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {},
              child:  SizedBox(
                height: 50,
                child: Align(
                    alignment: Alignment.centerLeft, child: children[index]),
              ));
        });
  }
}

class ProcessView extends StatelessWidget {
   ProcessView({super.key,required this.title});

  String title;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 60, child: Icon(Icons.file_copy, size: 30)),
        Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child:  Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                        )),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "100GB/1000GB",
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ))),
         Container(width: 70,padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: const Text("23:12:24",overflow: TextOverflow.ellipsis,)),
        Container(
            alignment: Alignment.centerLeft,
            width: 250,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: const Column(
              children: [
                LinearProgressIndicator(
                    minHeight: 10,
                    backgroundColor: Colors.amber,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: .5),
                SizedBox(width: double.infinity, child: Text("125KB/s"))
              ],
            )),
        SizedBox(
            width: 50,
            child: IconButton(
                splashRadius: 25,
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(Icons.cancel)))
      ],
    );
  }
}
