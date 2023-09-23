import 'package:file_manager/entry/Info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'api/user_operate.dart';
import 'setting.dart';
import 'component/ex_scaffold.dart';

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeApp(), routes: [
      GoRoute(
          path: 'setting',
          builder: (context, state) {
            final Map<String, InfoItem> params =
                state.extra! as Map<String, InfoItem>;
            final InfoItem info = params['info']!;
            return SettingPage(info: info);
          }),
      GoRoute(path: 'net', builder: (context, state) => const HomeApp())
    ]),
  ],
);

void main() => runApp(MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "首页",
      routerConfig: _router,
    ));

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<StatefulWidget> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  void reload() {
    UserOperateWeb.info().then((value) => {
          context.replace("/setting", extra: {"info": value})
        });
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("加载中");
  }
}
