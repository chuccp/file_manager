import 'package:file_manager/api/user_operate.dart';
import 'package:file_manager/bak/setting.dart';
import 'package:file_manager/entry/Info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'file_home_page.dart';
import 'file_transfer_page.dart';
import 'home.dart';
import 'login.dart';

void main() => runApp(const HomeApp());

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: Builder(
        builder: (BuildContext context) {
          return const SelectPage();
        },
      ));
}

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<StatefulWidget> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  late Future<InfoItem> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = UserOperateWeb.info();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InfoItem>(
      future: futureAlbum,
      builder: (BuildContext context, AsyncSnapshot<InfoItem> snapshot) {
        if (snapshot.hasData && snapshot.data!.hasInit!) {
          return const HomePage(title: "主页");
        }
        return const SettingPage(title: "设置页面");
      },
    );
  }
}
