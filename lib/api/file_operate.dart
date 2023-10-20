import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../entry/file.dart';
import 'file_operate_web.dart';
import '../util/platform.dart' as platform;

class FileOperate {
  static Future<List<FileItem>> listSync(
      {required String rootPath, required String path_}) {
    return FileOperateWeb.listSync(path_: path_, rootPath: rootPath);
  }

  static Future<bool> createNewFolder(
      {required String rootPath,
      required String path,
      required String folder}) {
    return FileOperateWeb.createNewFolder(
        rootPath: rootPath, path_: path, folder: folder);
  }

  static Future<bool> uploadNewFile(
      {required String rootPath,
      required String path,
      required FilePickerResult? pickerResult,
      required ProgressCallback progressCallback}) {
    return FileOperateWeb.uploadNewFile(
        path_: path,
        pickerResult: pickerResult,
        rootPath: rootPath,
        progressCallback: progressCallback);
  }
}
