import 'dart:collection';
import 'dart:ui';
import 'dart:io';
import 'package:file_manager/api/file_operate.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:provider/provider.dart';

import 'component/file_icon_button.dart';
import 'entry/file.dart';

class FilePageModel extends ChangeNotifier {
  final List<PathItem> _pathItem = [];
  final List<FileItem> _fileItems = [];

  final List<FocusNode> _focusNodes = [];

  UnmodifiableListView<PathItem> get items => UnmodifiableListView(_pathItem);

  PathItem get lastItem => _pathItem[_pathItem.length - 1];

  PathItem _backItems() {
    var i = index - 1;
    return _pathArrowItem[i - 1];
  }

  PathItem _forwardItems() {
    var i = index + 1;
    return _pathArrowItem[i - 1];
  }

  PathItem get backItems => _backItems();

  PathItem get forwardItems => _forwardItems();

  bool get hasBack => index > 1;

  bool get hasForward => index < _pathArrowItem.length;

  UnmodifiableListView<FileItem> get fileItems =>
      UnmodifiableListView(_fileItems);

  UnmodifiableListView<FocusNode> get focusNodes =>
      UnmodifiableListView(_focusNodes);

  int index = 0;
  final List<PathItem> _pathArrowItem = [];

  void disposeFocusNodes() {
    if (_focusNodes.isNotEmpty) {
      for (var fi in _focusNodes) {
        fi.unfocus();
      }
    }
    _focusNodes.clear();
  }

  void unFocusNodes() {
    if (_focusNodes.isNotEmpty) {
      for (var fi in _focusNodes) {
        fi.unfocus();
      }
    }
  }

  void toPath(String path, List<FileItem> fileItems, bool isArrow) {
    _focusNodes.addAll([for (var _ in fileItems) FocusNode()]);
    _pathItem.clear();
    _pathItem.addAll(PathItem.splitPath(path));
    _fileItems.clear();
    _fileItems.addAll(fileItems);
    if (!isArrow) {
      _pathArrowItem.clear();
      _pathArrowItem.addAll(_pathItem);
      index = _pathArrowItem.length;
    } else {
      index = _pathItem.length;
    }
    notifyListeners();
  }
}

class FileHomePage extends StatelessWidget {
  const FileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FilePageModel(),
      child: const FilePage(),
    );
  }
}

void loadFileAsset(BuildContext context, String path, bool isArrow) {
  Provider.of<FilePageModel>(context, listen: false).disposeFocusNodes();
  FileOperate.listSync(path_: path).then((value) => {
        Provider.of<FilePageModel>(context, listen: false)
            .toPath(path, value, isArrow)
      });
}

void createFolder(BuildContext context, String folder) {
  var lastItem = Provider.of<FilePageModel>(context, listen: false).lastItem;
  FileOperate.createNewFolder(path: lastItem.path, folder: folder)
      .then((value) => {
            if (value) {loadFileAsset(context, lastItem.path, false)}
          });
}




void uploadFile(BuildContext context,FilePickerResult? pickerResult){
  var lastItem = Provider.of<FilePageModel>(context, listen: false).lastItem;
  var path = lastItem.path;
  FileOperate.uploadNewFile(path: path, pickerResult: pickerResult).then((value) => {
    if (value) {loadFileAsset(context, lastItem.path, false)}
  });
}


class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<StatefulWidget> createState() => FilePageState();
}

class FilePageState extends State<FilePage> {
  @override
  void initState() {
    super.initState();
    loadFileAsset(context, "/", false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      var rowHeight = 35.0;
      return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: rowHeight,
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: OperateView(),
                ),
              ),
              const Divider(
                height: 0,
                indent: 0,
                endIndent: 0,
                color: Colors.black12,
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: rowHeight,
                  // color: Colors.amber,
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: PathView(),
                  )),
              const Divider(
                height: 0,
                indent: 0,
                endIndent: 0,
                color: Colors.black12,
              ),
              Container(
                  height: constraints.maxHeight - (rowHeight * 2) - 10,
                  color: Colors.white,
                  child: const FileListView())
            ],
          ));
    });
  }
}

class OperateView extends StatefulWidget {
  const OperateView({super.key});

  @override
  State<StatefulWidget> createState() => _OperateViewState();
}

class _OperateViewState extends State<OperateView> {
  final TextEditingController _unameController = TextEditingController();

  @override
  Widget build(BuildContext context2) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
      child: Row(children: <Widget>[
        ElevatedButton.icon(
          icon: const Icon(Icons.upload),
          label: const Text("上传"),
          onPressed: () {
            Future<FilePickerResult?> result = FilePicker.platform.pickFiles();
            result.then((value) {
              if (value != null) {
                uploadFile(context2, value);
              }
            });
          },
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.create_new_folder),
              label: const Text("新建文件夹"),
              onPressed: () => showDialog<String>(
                  context: context2,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text('新建文件夹'),
                          content: TextField(
                            autofocus: true,
                            controller: _unameController,
                            decoration: const InputDecoration(
                                hintText: "文件名",
                                prefixIcon: Icon(Icons.folder)),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('取消'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_unameController.text.isNotEmpty) {
                                  createFolder(context2, _unameController.text);
                                  _unameController.clear();
                                }
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('确认'),
                            ),
                          ])),
            )),
      ]),
    );
  }
}

class PathView extends StatefulWidget {
  const PathView({super.key});

  @override
  State<StatefulWidget> createState() => _PathViewState();
}

class _PathViewState extends State<PathView> {
  @override
  Widget build(BuildContext context) {
    var items = Provider.of<FilePageModel>(context).items;
    final List<Widget> children = <Widget>[
      for (var pathItem in items) Text("${pathItem.name}>")
    ];

    var hasBack = Provider.of<FilePageModel>(context).hasBack;
    var hasForward = Provider.of<FilePageModel>(context).hasForward;
    return Row(
      children: <Widget>[
        IconButton(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          icon: const Icon(Icons.arrow_back_ios),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: !hasBack
              ? null
              : () {
                  PathItem pathItem = Provider.of<FilePageModel>(context, listen: false).backItems;
                  loadFileAsset(context, pathItem.path, true);
                },
        ),
        SizedBox(
            width: 40,
            child: IconButton(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              highlightColor: Colors.white,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !hasForward
                  ? null
                  : () {
                      PathItem pathItem = Provider.of<FilePageModel>(context, listen: false).forwardItems;
                      loadFileAsset(context, pathItem.path, true);
                    },
            )),
        Row(
          children: children,
        )
      ],
    );
  }
}

class FileListView extends StatefulWidget {
  const FileListView({super.key});

  @override
  State<StatefulWidget> createState() => FileListViewState();
}

class FileListViewState extends State<FileListView> {
  @override
  Widget build(BuildContext context) {
    var items = Provider.of<FilePageModel>(context).fileItems;
    var focusNodes = Provider.of<FilePageModel>(context).focusNodes;
    final List<Widget> children = <Widget>[
      for (int i = 0; i < items.length; i++)
        FileIconButton.fileItem(
          fileItem: items[i],
          focusNode: focusNodes.elementAt(i),
          onPressed: () => {focusNodes.elementAt(i).requestFocus()},
          onDoubleTap: () {
            if (items[i].isDir) {
              loadFileAsset(context, items[i].path, false);
            } else {
              Future.delayed(const Duration(milliseconds: 100)).then((value) {
                FilePicker.platform.saveFile(fileName: items[i].name).then((value) {
                  if (value != null && value.isNotEmpty) {
                    FileOperate.downLoadFile(fileItem: items[i], localPath: value);
                  }
                });
              });

              Provider.of<FilePageModel>(context, listen: false).unFocusNodes();
            }
          },
        )
    ];
    return GestureDetector(
      onTap: () =>
          {Provider.of<FilePageModel>(context, listen: false).unFocusNodes()},
      child: GridView.extent(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        maxCrossAxisExtent: 120.0,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: children,
      ),
    );
  }
}
