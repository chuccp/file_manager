import 'dart:collection';

import 'package:file_manager/component/ex_load.dart';
import 'package:file_manager/file/file_setting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:provider/provider.dart';

import '../api/file_operate.dart';
import '../api/user_operate.dart';
import '../component/ex_tree_tab.dart';
import '../entry/Info.dart';
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

void loadFileAsset({required BuildContext context,required String rootPath, required String path, required bool isArrow}) {
  Provider.of<FilePageDelegate>(context, listen: false).disposeFocusNodes();
  FileOperate.listSync(path_: path, rootPath: rootPath).then((value) => {
        Provider.of<FilePageDelegate>(context, listen: false)
            .toPath(path, value, isArrow)
      });
}

void createFolder({required BuildContext context,required String rootPath, required String folder}) {
  var lastItem = Provider.of<FilePageDelegate>(context, listen: false).lastItem;
  FileOperate.createNewFolder(path: lastItem.path, folder: folder)
      .then((value) => {
            if (value) {loadFileAsset(context:context,rootPath:rootPath, path:lastItem.path, isArrow:false)}
          });
}

void uploadFile(BuildContext context,String rootPath, FilePickerResult? pickerResult) {
  var lastItem = Provider.of<FilePageDelegate>(context, listen: false).lastItem;
  var path = lastItem.path;
  FileOperate.uploadNewFile(path: path, pickerResult: pickerResult, rootPath: rootPath)
      .then((value) => {
            if (value) {loadFileAsset(context:context,rootPath:rootPath, path:lastItem.path, isArrow:false)}
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
  int _selectedTab = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        drawerBreakpoint: const WidthPlatformBreakpoint(end: 700),
        mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
        largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
        useDrawer: true,
        extendedNavigationRailWidth: 120,
        internalAnimations: false,
        selectedIndex: _selectedTab,
        onSelectedIndexChange: (index) => {_onItemTapped(index)},
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
          if (_selectedTab == 2) {
            return const FileSettingPage();
          }
          if (_selectedTab == 0) {
            return const FileTreePage();
          }
          return const ExLoading();
        });
  }
}

class FileTreePage extends StatefulWidget {
  const FileTreePage({super.key});

  @override
  State<StatefulWidget> createState() => _FileTreePageState();
}

class _FileTreePageState extends State<FileTreePage> {
  List<Node> nodes = [];

  String selectedKey = "";

  _updateNode(List<Node> nodes) {
    setState(() {
      this.nodes.clear();
      this.nodes.addAll(nodes);
      selectedKey = nodes[0].key;
    });
  }

  @override
  void initState() {
    UserOperateWeb.queryAllPath().then((value) => {
          _updateNode(<Node>[
            for (var v in value.data!.list!)
              Node(
                label: v.name!,
                key: v.path!,
                icon: Icons.folder,
                expanded: false,
              )
          ])
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExTreeTable(
      selectedKey: selectedKey,
      nodes: nodes,
      body: (_, index) {
        if (index == "") {
          return const ExLoading();
        }
        print(index);
        return FileShowPage(
          rootPath: index,
        );
      },
    ));
  }
}

class FileShowPage extends StatefulWidget {
  const FileShowPage({super.key, required this.rootPath});

  final String rootPath;

  @override
  State<StatefulWidget> createState()=>_FileShowPageState();


}
class _FileShowPageState extends State<FileShowPage>{
  @override
  Widget build(BuildContext context) {
    // print("rootPath ${widget.rootPath}");

    loadFileAsset(context:context,rootPath:widget.rootPath, path: "/", isArrow:false);

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
      child:  Column(
        children: [
          const FileOperateView(),
          const Divider(
            height: 0,
            indent: 0,
            endIndent: 0,
            color: Colors.black12,
          ),
          FilePathView(rootPath: widget.rootPath,),
          const Divider(
            height: 0,
            indent: 0,
            endIndent: 0,
            color: Colors.black12,
          ),
          Expanded(child: FileListShowView(rootPath: widget.rootPath,)),
        ],
      ),
    );
  }
}