import 'package:flutter/cupertino.dart';

import '../component/ex_tree_file.dart';

class FileUserSetting extends StatefulWidget {
  const FileUserSetting({super.key});

  @override
  State<StatefulWidget> createState() => _FileUserSettingState();
}

class _FileUserSettingState extends State<FileUserSetting> {
  @override
  Widget build(BuildContext context) {
    return const ExTreeFile();
  }
}
