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
        Provider.of<FilePageDelegate>(context, listen: false)
            .updateProgresses(progress);
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

void createFolder(
    {required BuildContext context,
    required String rootPath,
    required String folder}) {
  var lastItem = Provider.of<FilePageDelegate>(context, listen: false).lastItem;
  FileOperate.createNewFolder(path: lastItem.path, folder: folder, rootPath: rootPath)
      .then((value) => {
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
    final TextEditingController unameController = TextEditingController();
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
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context2) => AlertDialog(
                                  title: const Text('新建文件夹'),
                                  content: TextField(
                                    autofocus: true,
                                    controller: unameController,
                                    decoration: const InputDecoration(
                                        hintText: "文件名",
                                        prefixIcon: Icon(Icons.folder)),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context2, 'Cancel'),
                                      child: const Text('取消'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (unameController.text.isNotEmpty) {
                                          var rootPath =
                                              Provider.of<FilePageDelegate>(
                                                      context,
                                                      listen: false)
                                                  .rootPath;
                                          createFolder(
                                              context: context!,
                                              rootPath: rootPath,
                                              folder: unameController.text);
                                          unameController.clear();
                                        }
                                        Navigator.pop(context2, 'OK');
                                      },
                                      child: const Text('确认'),
                                    ),
                                  ])),
                    ),
                  ),
                ],
              ))),
    );
  }
}
