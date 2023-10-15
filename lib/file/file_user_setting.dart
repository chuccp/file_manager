import 'package:flutter/cupertino.dart';

import '../api/file_operate_web.dart';
import '../component/ex_tree_file.dart';
import '../entry/file.dart';

class FileUserSetting extends StatefulWidget {
  const FileUserSetting({super.key});

  @override
  State<StatefulWidget> createState() => _FileUserSettingState();
}

class _FileUserSettingState extends State<FileUserSetting> {
  @override
  Widget build(BuildContext context) {
    return ExTreeFile(
      root: () {
       return FileOperateWeb.rootListSync();
      },
        path:(key){
          return FileOperateWeb.pathListSync(path_: key);
        }
    );
  }
}
