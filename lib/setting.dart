import 'dart:html';

import 'package:file_manager/component/ex_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'api/user_operate.dart';
import 'component/ex_dialog.dart';
import 'component/ex_scaffold.dart';
import 'entry/Info.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.info});

  final InfoItem info;

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final router2 = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => SignUpPage(info: widget.info),
            routes: [
              GoRoute(
                path: 'net',
                builder: (context, state) => NetSetPage(info: widget.info),
              ),
              GoRoute(
                path: 'cert',
                builder: (context, state) => CertPage(info: widget.info),
              )
            ]),
      ],
      initialLocation: widget.info.hasInit ? "/net" : "",
    );
    return ExScaffold(
      title: "账号设置",
      body: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "账号设置",
        routerConfig: router2,
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.info});

  final InfoItem info;

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _useNatSelected = false;
  bool _beNatSelected = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExCard(
        title: "账号设置",
        width: 400,
        height: 440,
        footer: Align(
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
                    UserOperateWeb.addAdminUser(context,
                            username: usernameController.value.text,
                            password: passwordController.value.text,
                            rePassword: rePasswordController.value.text,
                            isNatClient: _useNatSelected,
                            isNatServer: _beNatSelected)
                        .then((value) {
                      if (value.isOK()) {
                        context.replace("/net");
                      } else {
                        alertDialog(context: context, msg: value.data);
                      }
                    });

                    // context.replace("/net");
                  },
                )
              ],
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            const Text(
              "设置管理员账号",
              textAlign: TextAlign.left,
            ),
            TextField(
              autofocus: true,
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名",
                  prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: "登录密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            TextField(
              controller: rePasswordController,
              decoration: const InputDecoration(
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
          ],
        ));
  }
}

class NetSetPage extends StatefulWidget {
  const NetSetPage({super.key, required this.info});

  final InfoItem info;

  @override
  State<StatefulWidget> createState() => _NetSetPageState();
}

class _NetSetPageState extends State<NetSetPage> {
  @override
  Widget build(BuildContext context) {

    var address = widget.info.address;

    var hostControllers = <TextEditingController>[
      for (int i = 0; i < address!.length; i++)
        TextEditingController(text:address.elementAt(i).host )
    ];
    var portControllers = <TextEditingController>[
      for (int i = 0; i < address!.length; i++)
        TextEditingController(text:address.elementAt(i).port.toString() )
    ];
    var wList = <Widget>[
      for (int i = 0; i < address!.length; i++)
        SizedBox(
          width: 380,
          child: Flex(direction: Axis.horizontal, children: <Widget>[
            const Spacer(
              flex: 1,
            ),
             Expanded(
              flex: 4,
              child: TextField(
                controller: hostControllers.elementAt(i),
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "IP地址",
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
             Expanded(
              flex: 4,
              child: TextField(
                controller: portControllers.elementAt(i),
                decoration: const InputDecoration(
                  labelText: "端口号",
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("测试"),
              ),
            )
          ]),
        )
    ];

    return ExCard(
      title: "网络设置",
      width: 400,
      height: 500,
      footer: Wrap(
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
              context.replace("/cert");
            },
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: wList,
      ),
    );
  }
}

class CertPage extends StatefulWidget {
  const CertPage({super.key, required this.info});

  final InfoItem info;

  @override
  State<StatefulWidget> createState() => _CertPageState();
}

class _CertPageState extends State<CertPage> {
  @override
  Widget build(BuildContext context) {
    return ExCard(
      title: "设置完成",
      width: 400,
      height: 500,
      footer: SizedBox(
          width: 300,
          child: Flex(direction: Axis.horizontal, children: <Widget>[
            Expanded(
              flex: 3,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("下载证书"),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  context.replace("/");
                },
                child: const Text("去登录"),
              ),
            )
          ])),
      child: const Text("远程登录的时候需要证书才能登录，避免被监听"),
    );
  }
}
