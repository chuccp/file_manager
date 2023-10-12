import 'dart:collection';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:provider/provider.dart';

import '../api/file_operate.dart';
import '../entry/file.dart';
import 'file_list.dart';
import 'file_operate.dart';
import 'file_path_view.dart';

class FilePageDelegate extends ChangeNotifier {
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

  UnmodifiableListView<FileItem> get fileItems => UnmodifiableListView(_fileItems);

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


void loadFileAsset(BuildContext context, String path, bool isArrow) {
  Provider.of<FilePageDelegate>(context, listen: false).disposeFocusNodes();
  FileOperate.listSync(path_: path).then((value) => {
    Provider.of<FilePageDelegate>(context, listen: false).toPath(path, value, isArrow)
  });
}

void createFolder(BuildContext context, String folder) {
  var lastItem = Provider.of<FilePageDelegate>(context, listen: false).lastItem;
  FileOperate.createNewFolder(path: lastItem.path, folder: folder)
      .then((value) => {
    if (value) {loadFileAsset(context, lastItem.path, false)}
  });
}

void uploadFile(BuildContext context, FilePickerResult? pickerResult) {
  var lastItem = Provider.of<FilePageDelegate>(context, listen: false).lastItem;
  var path = lastItem.path;
  FileOperate.uploadNewFile(path: path, pickerResult: pickerResult)
      .then((value) => {
    if (value) {loadFileAsset(context, lastItem.path, false)}
  });
}


class FileManage extends StatelessWidget {
  const FileManage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FilePageDelegate(),
      child: const FileDelegateManage(),
    );
  }
}

class FileDelegateManage extends StatefulWidget {
  const FileDelegateManage({super.key});

  @override
  State<StatefulWidget> createState() => _FileDelegateManageState();
}

class _FileDelegateManageState extends State<FileDelegateManage> {



  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        drawerBreakpoint: const WidthPlatformBreakpoint(end: 700),
        mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
        largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
        useDrawer: true,
        extendedNavigationRailWidth: 120,
        internalAnimations: false,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.inbox_outlined),
            selectedIcon: Icon(Icons.inbox),
            label: '空间',
          ),
          NavigationDestination(
            icon: Badge(label: Text("1"), child: Icon(Icons.sync_outlined)),
            selectedIcon: Badge(label: Text("1"), child: Icon(Icons.sync)),
            label: '传输',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
        body: (_) {
          return const FileShowPage();
        });
  }


}

class FileShowPage extends StatelessWidget {
  const FileShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
      child: const Card(
          child: Column(
        children: [
          FileOperateView(),
          Divider(
            height: 0,
            indent: 0,
            endIndent: 0,
            color: Colors.black12,
          ),
          FilePathView(),
          Divider(
            height: 0,
            indent: 0,
            endIndent: 0,
            color: Colors.black12,
          ),
          Expanded(child: FileListShowView()),
        ],
      )),
    );
  }
}
