import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../entry/file.dart';
import 'file_operate_local.dart';
import 'file_operate_web.dart';
import '../util/platform.dart' as platform;

class FileOperate {


  static Future<List<FileItem>> listSync({required String path_}) {
    if (platform.isWeb) {
      return FileOperateWeb.listSync(path_: path_);
    }
    return FileOperateLocal.listSync(path_: path_);
  }

  static Future<bool> createNewFolder(
      {required String path, required String folder}) {
    return FileOperateLocal.createNewFolder(path_: path, folder: folder);
  }



  static Future<bool> uploadNewFile({required String path, required FilePickerResult? pickerResult, ProgressCallback? progressCallback}) {
    if(platform.isWeb){
      print("===============");
      return FileOperateWeb.uploadNewFile(path_: path, pickerResult: pickerResult);
    }
    File file = File(pickerResult!.files.single.path!!);
    return FileOperateLocal.uploadNewFile(path_: path, file: file);
  }


  static Future<bool> downLoadFile(
      {required FileItem fileItem,
      required localPath,
      ProgressCallback? progressCallback}) {
    return FileOperateLocal.downloadFile(
        fileItem: fileItem,
        localPath: localPath,
        progressCallback: progressCallback);
  }
}
