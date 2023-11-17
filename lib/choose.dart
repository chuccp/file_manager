import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'component/ex_button_group.dart';
import 'component/ex_card.dart';
import 'component/ex_radio_group.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController modeController = TextEditingController();

    return ExCard(
      title: "模式选择",
      width: 400,
      height: 300,
      footer: ExButtonGroup(
        children: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go("/selectServer");
            },
            child: const Text("下一步"),
          )
        ],
      ),
      child: ExRadioGroup(
        titles: const ["客户端模式", "服务端模式"],
        values: const ["client", "server"],
        controller: modeController,
      ),
    );
  }
}
