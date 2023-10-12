import 'package:flutter/material.dart';

class FileOperateView extends StatelessWidget {
  const FileOperateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
              width: 300,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.upload),
                      label: const Text("上传文件"),
                      onPressed: () {},
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex:10,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.create_new_folder),
                      label: const Text("新建文件夹"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ))),
    );
  }
}
