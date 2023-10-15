import 'package:file_manager/component/ex_dialog.dart';
import 'package:flutter/material.dart';

import '../component/ex_card.dart';

class FilePathSetting extends StatefulWidget {
  const FilePathSetting({super.key});

  @override
  State<StatefulWidget> createState() => _FilePathSettingState();
}

class SourceData extends DataTableSource {
  int _selectedRow = 0;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      onSelectChanged: (bool? value) {
        _selectedRow = index;
        notifyListeners();
      },
      selected: _selectedRow == index,
      cells: const <DataCell>[
        DataCell(Text('Sarah')),
        DataCell(Text('19'))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 1;
}

class _FilePathSettingState extends State<FilePathSetting> {
  final DataTableSource _sourceData = SourceData();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
        child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
                width: 300,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("添加"),
                        onPressed: () {
                          exShowDialog(context: context,content: _AddPathView(), onPressed: () { 
                            return Future(() => true); 
                          });
                        },
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex:10,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text("修改"),
                        onPressed: () {

                        },
                      ),
                    ),  const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex:10,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text("删除"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ))),
      ),
      SizedBox(
        width: double.infinity,
        child: PaginatedDataTable(
          showCheckboxColumn: true,
          columns: const <DataColumn>[
            DataColumn(
              label: Text('名称'),
            ),
            DataColumn(
              label: Text('路径'),
            ),
          ],
          source: _sourceData,
        ),
      )
    ],);
  }
}
class _AddPathView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController(text: "111");
    final TextEditingController passwordController = TextEditingController(text: "111");
    return SizedBox(height:200,width: 300,child:Column(
      children: <Widget>[
        const Text(
          "添加",
          textAlign: TextAlign.left,
        ),
        TextField(
          autofocus: true,
          controller: usernameController,
          decoration: const InputDecoration(
              labelText: "别名",
              hintText: "别名",
              ),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
              labelText: "远程目录",
              hintText: "远程目录"),
        ),
      ],
    ) ,) ;
  }

}