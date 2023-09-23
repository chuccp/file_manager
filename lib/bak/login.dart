import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'file_home_page.dart';
import 'file_transfer_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              width: 400,
              height: 200,
              child: Card(
                  child: Column(
                children: <Widget>[
                  const Text(
                    "登录",
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
                        labelText: "密码",
                        hintText: "您的登录密码",
                        prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    widthFactor: 400,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      width: 200,
                      child: Wrap(
                        spacing: 20,
                        children: [

                          OutlinedButton.icon(
                            icon: const Icon(Icons.cancel),
                            label: const Text("取消"),
                            onPressed: () {},
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.login),
                            label: const Text("登录"),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )))),
    );
  }
}
