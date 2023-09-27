import 'dart:convert';

import 'package:file_manager/entry/Info.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'api/user_operate.dart';
import 'setting.dart';
import 'component/ex_scaffold.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeApp(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/', builder: (context, state) => const LoadingPage())
          ]),
          StatefulShellBranch(routes: [
            StatefulShellRoute.indexedStack(
                builder: (context, state, navigationShell) {
                  return SettingPage(
                    navigationShell: navigationShell,
                  );
                },
                branches: [
                  StatefulShellBranch(routes: [
                    GoRoute(
                        path: '/signUp',
                        redirect: (context, state) {
                          if (state.extra == null) {
                            return "/";
                          }
                        },
                        builder: (context, state) {
                          if (state.extra == null) {
                            GoRouter.of(context).go("/");
                            return const LoadingPage();
                          }
                          final Map<String, InfoItem> params =
                              state.extra! as Map<String, InfoItem>;
                          final InfoItem info = params['info']!;
                          return SignUpPage(info: info);
                        })
                  ]),
                  StatefulShellBranch(routes: [
                    GoRoute(
                        path: '/netSetPage',
                        redirect: (context, state) {
                          if (state.extra == null) {
                            return "/";
                          }
                        },
                        builder: (context, state) {
                          final Map<String, InfoItem> params =
                              state.extra! as Map<String, InfoItem>;
                          final InfoItem info = params['info']!;
                          return NetSetPage(info: info);
                        })
                  ]),
                ])
          ]),
        ])
  ],
);

void main() => runApp(MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "首页",
      routerConfig: _router,
    ));

class HomeApp extends StatefulWidget {
  const HomeApp({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  void reload() {
    UserOperateWeb.info().then((value) {
      GoRouter.of(context).go("/signUp", extra: {"info": value});
    });
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return widget.navigationShell;
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("加载中");
  }
}
