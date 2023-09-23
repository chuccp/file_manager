import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/ex_card.dart';


final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginInfo(), routes: [
      GoRoute(
        path: 'nat',
        builder: (context, state) => const NatSettingPage(),
      ),GoRoute(
        path: 'cert',
        builder: (context, state) => const CertGenPage(),
      )
    ]),
  ],
);

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: MaterialApp.router(
                routerConfig: _router,
              )),
        ));
  }
}

class LoginInfo extends StatefulWidget {
  const LoginInfo({super.key});

  @override
  State<StatefulWidget> createState() => _LoginInfoState();
}

class _LoginInfoState extends State<LoginInfo> {
  bool _useNatSelected = false;
  bool _beNatSelected = false;

  @override
  Widget build(BuildContext context) {
    return ExCard(
      width: 400,
      height: 400,
      child: Column(
        children: <Widget>[
          const Text(
            "设置管理员账号",
            textAlign: TextAlign.left,
          ),
          const TextField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: "用户名",
                hintText: "用户名",
                prefixIcon: Icon(Icons.person)),
          ),
          const TextField(
            decoration: InputDecoration(
                labelText: "登录密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock)),
            obscureText: true,
          ),
          const TextField(
            decoration: InputDecoration(
                labelText: "确认密码",
                hintText: "确认登录密码",
                prefixIcon: Icon(Icons.repeat)),
            obscureText: true,
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: _useNatSelected,
            onChanged: (bool? value) {
              setState(() {
                _useNatSelected = !_useNatSelected;
              });
            },
            subtitle: const Text('连接节点，使用NAT穿透服务'),
            title: const Text('是否使用NAT穿透服务'),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: _beNatSelected,
            onChanged: (bool? value) {
              setState(() {
                _beNatSelected = !_beNatSelected;
              });
            },
            subtitle: const Text('作为节点，提供NAT穿透服务'),
            title: const Text('是否提供NAT穿透服务'),
          ),
          Align(
            alignment: Alignment.topCenter,
            widthFactor: 400,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: 210,
              child: Wrap(
                spacing: 10,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: const Text("下一步"),
                    onPressed: () {
                      context.go("/nat");
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NatSettingView extends StatelessWidget {
  const _NatSettingView({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 5,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: 20,
              child: ListTile(title: Text(title))),
          const SizedBox(
              width: 140,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "IP地址",
                ),
              )),
          const SizedBox(
              width: 100,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "端口号",
                ),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  context.go("/cert");
                },
                child: const Text("测试"),
              ))
        ],
      ),
    );
  }
}

class NatSettingPage extends StatefulWidget {
  const NatSettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _NatSettingPageState();
}

class _NatSettingPageState extends State<NatSettingPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[
      for (var i = 0; i <= 3; i++)
        _NatSettingView(
          title: "${i + 1}",
        )
    ];

    return ExCard(
      width: 400,
      height: 440,
      child: Column(
        children: <Widget>[
          const ListTile(title: Text("远程节点列表")),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return list.elementAt(index);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            width: 200,
            height: 40,
            child: Wrap(
              spacing: 20,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("添加"),
                  onPressed: () {},
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text("确认"),
                  onPressed: () {
                    context.go("/cert");
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CertGenPage extends StatefulWidget {
  const CertGenPage({super.key});

  @override
  State<StatefulWidget> createState() => _CertGenPageState();
}

class _CertGenPageState extends State<CertGenPage> {
  @override
  Widget build(BuildContext context) {
    return const ExCard(
        width: 400,
        height: 440,
      child: Column(
        children: [
           ListTile(title: Text("设置完成")),
        ],
      ),
    );
  }
}
