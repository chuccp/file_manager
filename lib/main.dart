import 'package:file_manager/entry/Info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'api/user_operate.dart';
import 'setting.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(Builder(
    builder: (BuildContext context) {
      final router = GoRouter(
        initialLocation: "/load",
        routes: [
          StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) {
                return HomeApp(
                  navigationShell: navigationShell,
                );
              },
              branches: [
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/load',
                    builder: (context, state) {
                      return const LoadingPage();
                    },
                  ),
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
                            pageBuilder: (context, state) {
                              final Map<String, InfoItem> params =
                                  state.extra! as Map<String, InfoItem>;
                              final InfoItem info = params['info']!;
                              return MaterialPage(
                                  child: SignUpPage(info: info));
                            },
                          )
                        ]),
                        StatefulShellBranch(routes: [
                          GoRoute(
                              path: '/CertPage',
                              redirect: (context, state) {
                                if (state.extra == null) {
                                  return "/";
                                }
                              },
                              builder: (context, state) {
                                final Map<String, InfoItem> params =
                                    state.extra! as Map<String, InfoItem>;
                                final InfoItem info = params['info']!;
                                return CertPage(info: info);
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

      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "首页",
        routerConfig: router,
      );
    },
  ));
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {


  @override
  Widget build(BuildContext context) {
    return widget.navigationShell;
  }

}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  // final String keyId;

  @override
  State<StatefulWidget> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("加载中");
  }

  void go() {
    UserOperateWeb.info().then((value) {
      GoRouter.of(context).go("/signUp", extra: {"info": value});
    });
  }

  @override
  void initState() {
    // print(widget.keyId);
    go();
  }
}
