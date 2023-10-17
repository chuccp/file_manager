import 'package:file_manager/api/user_operate.dart';
import 'package:file_manager/component/ex_dialog.dart';
import 'package:flutter/material.dart';

import '../api/file_operate_web.dart';
import '../component/ex_card.dart';
import '../component/ex_tree_file.dart';
import '../entry/page.dart';
import '../entry/path.dart';

class FilePathSetting extends StatefulWidget {
  const FilePathSetting({super.key});

  @override
  State<StatefulWidget> createState() => _FilePathSettingState();
}

class SourceData extends DataTableSource {
  final _pathList = <ExPath>[];

  int _selectedRow = 0;

  int _rowCount = 0;

  final int _pageSize = 10;

  int _pageNo = 1;

  void updateSourceData(ExPage<ExPath> page, int pageNo) {
    _pathList.clear();
    _rowCount = page.total!;
    for (var value in page.list!) {
      _pathList.add(value);
    }
    _pageNo = pageNo;
    notifyListeners();
  }


  void refresh(){
    UserOperateWeb.queryPath(pageNo: _pageNo-1, pageSize: 10).then((value) {
      updateSourceData(value.data!, _pageNo);
    });
  }

  @override
  DataRow? getRow(int index) {
    int pageNo = (index ) ~/ _pageSize+1;
    if (pageNo != _pageNo) {
      if ((index % 10 == 9)|| index==(_rowCount-1)) {
        if(pageNo>_pageNo){
          UserOperateWeb.queryPath(pageNo: _pageNo, pageSize: 10).then((value) {
            updateSourceData(value.data!, _pageNo + 1);
          });
        }else{
          UserOperateWeb.queryPath(pageNo: _pageNo-2, pageSize: 10).then((value) {
            updateSourceData(value.data!, _pageNo - 1);
          });
        }
      }
      return const DataRow(
        cells: <DataCell>[DataCell(Text("")), DataCell(Text(""))],
      );
    }
    index = index%10;
    var path = _pathList[index];
    var cells = <DataCell>[
      DataCell(Text(path.name!)),
      DataCell(Text(path.path!))
    ];
    return DataRow(
      onSelectChanged: (bool? value) {
        _selectedRow = index;
        notifyListeners();
      },
      selected: _selectedRow == index,
      cells: cells,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rowCount;

  @override
  int get selectedRowCount => 1;
}

class _FilePathSettingState extends State<FilePathSetting> {
  final SourceData _sourceData = SourceData();

  @override
  void initState() {
    _sourceData.refresh();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController pathController = TextEditingController();

    return ListView(
      children: [
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
                            exShowDialog(
                                context: context,
                                content: _AddPathView(
                                  nameController: nameController,
                                  pathController: pathController,
                                ),
                                onPressed: () {
                                  return UserOperateWeb.addPath(
                                          name: nameController.text,
                                          path: pathController.text)
                                      .then((value) {
                                    if (value.isOK()) {
                                      _sourceData.refresh();
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  });
                                });
                          },
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 10,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.edit),
                          label: const Text("修改"),
                          onPressed: () {},
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 10,
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
      ],
    );
  }
}

class _AddPathView extends StatefulWidget {
  const _AddPathView(
      {required this.nameController, required this.pathController});

  final TextEditingController nameController;

  final TextEditingController pathController;

  @override
  State<StatefulWidget> createState() => _AddPathViewState();
}

class _AddPathViewState extends State<_AddPathView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 400,
      child: Column(
        children: <Widget>[
          const Text(
            "添加",
            textAlign: TextAlign.left,
          ),
          TextField(
            autofocus: true,
            controller: widget.nameController,
            decoration: const InputDecoration(
              labelText: "别名",
              hintText: "别名",
            ),
          ),
          TextField(
            readOnly: true,
            controller: widget.pathController,
            decoration:
                const InputDecoration(labelText: "远程目录", hintText: "从下面选择路径"),
          ),
          ExTreeFile(
            root: () {
              return FileOperateWeb.rootListSync();
            },
            path: (key) {
              return FileOperateWeb.pathListSync(path_: key);
            },
            onChanged: (String value) {
              widget.pathController.text = value;
            },
          )
        ],
      ),
    );
  }
}
