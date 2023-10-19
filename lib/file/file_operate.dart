import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/file_operate.dart';
import '../entry/progress.dart';
import 'file_mange.dart';

void uploadFile(
    BuildContext context, String rootPath, FilePickerResult? pickerResult) {
  var lastItem = Provider.of<FilePageDelegate>(context, listen: false).lastItem;
  var path = lastItem.path;
  var id = DateTime.timestamp().millisecond;
  String? name = pickerResult?.names.first;
  FileOperate.uploadNewFile(
      path: path,
      pickerResult: pickerResult,
      rootPath: rootPath,
      progressCallback: (int count, int total) {
        var progress =
            Progress(id: id.toString(), name: name, count: count, total: total);
        Provider.of<FilePageDelegate>(context, listen: false).updateProgresses(progress);
      }).then((value) => {
        if (value)
          {
            loadFileAsset(
                context: context,
                rootPath: rootPath,
                path: lastItem.path,
                isArrow: false)
          }
      });
}

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
                      onPressed: () {
                        var rootPath = Provider.of<FilePageDelegate>(context,
                                listen: false)
                            .rootPath;
                        Future<FilePickerResult?> result =
                            FilePicker.platform.pickFiles(withReadStream: true);
                        result.then((value) {
                          if (value != null) {
                            uploadFile(context, rootPath, value);
                          }
                        });
                      },
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 10,
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
