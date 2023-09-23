import 'package:flutter/material.dart';

import '../component/listview_navigation.dart';



class FileTransferPage extends StatefulWidget {
  const FileTransferPage({super.key});

  @override
  State<StatefulWidget> createState() => _FileTransferPageState();
}

class _FileTransferPageState extends State<FileTransferPage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<NavigationRailDestination> entries2 =
        <NavigationRailDestination>[
      const NavigationRailDestination(
          icon: Icon(Icons.download_outlined),
          selectedIcon: Icon(Icons.download),
          label: Text('下载中')),
      const NavigationRailDestination(
          icon: Icon(Icons.upload_outlined),
          selectedIcon: Icon(Icons.upload),
          label: Text('上传中')),
      const NavigationRailDestination(
          icon: Icon(Icons.file_download_done_outlined),
          selectedIcon: Icon(Icons.file_download_done),
          label: Text('已完成'))
    ];

    return ListviewWithNavigation(
      destinations: entries2,
      selectedIndex: selectedIndex,
      onSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      builder: (BuildContext context) {


        return  Text("AAAA$selectedIndex");


      },
    );
  }
}
