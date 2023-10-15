import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../api/user_operate.dart';
import '../component/ex_card.dart';
import '../component/ex_dialog.dart';
import '../component/ex_scaffold.dart';
import '../util/local_store.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController(text: "111");
    final TextEditingController passwordController = TextEditingController(text: "111");
    return ExScaffold(
      title: "账号登录",
      body: ExCard(
          title: "账号登录",
          width: 400,
          height: 320,
          footer: Wrap(
            spacing: 20,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.cancel),
                label: const Text("清空"),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text("确认"),
                onPressed: () {
                  UserOperateWeb.signIn(
                          username: usernameController.text,
                          password: passwordController.text)
                      .then((value) {
                    if (value.isOK()) {
                      String token = value.data;
                      LocalStore.saveToken(token: token).then((value) => {
                        GoRouter.of(context).go("/file", extra: {"info": value})
                      });
                    } else {
                      {
                        alertDialog(context: context, msg: value.data);
                      }
                    }
                  });
                  ;
                },
              )
            ],
          ),
          child: Column(
            children: <Widget>[
              const Text(
                "输入账号",
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
            ],
          )),
    );
  }
}
