import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            GoRoute(path: '/', builder: (context, state) => const SettingPage())
          ]),
          StatefulShellBranch(routes: [
            StatefulShellRoute.indexedStack(
                builder: (context, state, navigationShell) {
                  return NetPage(
                    navigationShell: navigationShell,
                  );
                },
                branches: [
                  StatefulShellBranch(routes: [
                    GoRoute(
                        path: '/net',
                        builder: (context, state) => const FeedDetailsPage())
                  ]),
                  StatefulShellBranch(routes: [
                    GoRoute(
                        path: '/net/SettingPage',
                        builder: (context, state) => const SettingPage())
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

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("SettingPage");
  }
}

class FeedDetailsPage extends StatelessWidget {
  const FeedDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("FeedDetailsPage");
  }
}

class NetPage extends StatelessWidget {
  const NetPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
        const Text("NetPage"),
      SizedBox(
        height: 100,
        width: 400,
        child: navigationShell,
      )
    ],);
  }
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 200,
          width: 500,
          child: navigationShell,
        )
      ],
    );
  }
}
