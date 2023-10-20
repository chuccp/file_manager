import 'package:file_manager/component/ex_load.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../api/file_operate.dart';
import '../component/file_icon_button.dart';
import 'file_mange.dart';

class FileListShowView extends StatefulWidget {
   FileListShowView({super.key, required this.rootPath});

   String rootPath;

  @override
  State<StatefulWidget> createState() => _FileListShowViewState();
}

class _FileListShowViewState extends State<FileListShowView> {



  @override
  Widget build(BuildContext context) {
    var items = Provider.of<FilePageDelegate>(context).fileItems;
    var focusNodes = Provider.of<FilePageDelegate>(context).focusNodes;
    if (items.isEmpty || focusNodes.isEmpty){
      return const ExLoading();
    }
    final List<Widget> children = <Widget>[
      for (int i = 0; i < items.length; i++)
        FileIconButton.fileItem(
          fileItem: items[i],
          focusNode: focusNodes.elementAt(i),
          onPressed: () => {focusNodes.elementAt(i).requestFocus()},
          onDoubleTap: () {
            if (items[i].isDir) {
              loadFileAsset(context:context, rootPath:widget.rootPath, path:items[i].path, isArrow:false);
            } else {
              Future.delayed(const Duration(milliseconds: 100)).then((value) {
                // FilePicker.platform.saveFile(fileName: items[i].name).then((value) {
                //   if (value != null && value.isNotEmpty) {
                //     FileOperate.downLoadFile(fileItem: items[i], localPath: value);
                //   }
                // });
              });
              Provider.of<FilePageDelegate>(context, listen: false).unFocusNodes();
            }
          },
        )
    ];
    return Container(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
        child: GestureDetector(
          onTap: () => {},
          child: GridView.extent(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            maxCrossAxisExtent: 120.0,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: children,
          ),
        ));
  }


}
