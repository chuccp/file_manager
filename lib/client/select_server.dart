import 'package:flutter/material.dart';
import '../component/ex_address_input.dart';
import '../component/ex_button_group.dart';
import '../component/ex_card.dart';

class SelectServerPage extends StatefulWidget {
  const SelectServerPage({super.key});

  @override
  State<StatefulWidget> createState() => _SelectServerPageState();
}

class _SelectServerPageState extends State<SelectServerPage> {
  @override
  Widget build(BuildContext context) {
    return ExCard(
      width: 400,
      height: 600,
      title: "选择网络",
      footer: ExButtonGroup(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text("连接网络"),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
              children: [
                const ListTile(title: Text("要连接网络")),
                AddressInput(
                  onTestPressed: () {},
                  onChangePressed: (){},
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(child:  Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
              children: [
                const ListTile(title: Text("节点服务器")),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("添加"),
                    onPressed: () {},
                  ),
                ),
                AddressInput(
                  onTestPressed: () {},
                  onDeletePressed: () {},
                )
              ],
            ),
          ),),

        ],
      ),
    );
  }
}
