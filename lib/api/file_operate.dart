import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../entry/file.dart';
import 'file_operate_local.dart';
import 'file_operate_web.dart';
import '../util/platform.dart' as platform;

class FileOperate {


  static Future<List<FileItem>> listSync({required String rootPath,required String path_}) {
    if (platform.isWeb) {
      return FileOperateWeb.listSync(path_: path_, rootPath: rootPath);
    }
    return FileOperateLocal.listSync(path_: path_);
  }

  static Future<bool> createNewFolder(
      {required String path, required String folder}) {
    return FileOperateLocal.createNewFolder(path_: path, folder: folder);
  }



  static Future<bool> uploadNewFile({required String rootPath,required String path, required FilePickerResult? pickerResult, required ProgressCallback progressCallback}) {
    if(platform.isWeb){
      return FileOperateWeb.uploadNewFile(path_: path, pickerResult: pickerResult, rootPath:rootPath,progressCallback:progressCallback);
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
