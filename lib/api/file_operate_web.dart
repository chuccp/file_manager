import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'dart:developer' as developer;
import '../entry/file.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class FileOperateWeb {
  static String root = "http://127.0.0.1:2156/";

  static Future<List<Future<FileItem>>> list({required String path_}) {
    if (path_.startsWith("/") || path_.startsWith("\\")) {
      path_ = path_.substring(1);
    }
    var absolutePath = path.absolute(root, path_);
    var dir = io.Directory(absolutePath);
    Stream<io.FileSystemEntity> list = dir.list();
    var fList2 = list.map((event) => event.stat().then((stat) => FileItem(
        path.basename(event.path),
        path.relative(event.path, from: root),
        stat.type == io.FileSystemEntityType.directory,
        (stat.type == io.FileSystemEntityType.directory) ? 0 : stat.size,
        stat.modified)));
    return fList2.toList();
  }

  static Future<bool> uploadNewFile(
      {required String path_,
      required FilePickerResult? pickerResult,
      dio.ProgressCallback? progressCallback}) async {
    PlatformFile? platformFile = pickerResult?.files.first;
    if (platformFile != null ) {
      final formData = dio.FormData.fromMap({
        'Path': path_,
        'file': dio.MultipartFile.fromStream(
            () =>platformFile.readStream!, platformFile.size,
            filename: platformFile.name)
      });
      print("=========1${root}upload");
      var response = await httpClient.post("${root}upload", data: formData);
      print("==========2${root}upload");
      if (response.statusCode == 200) {
        return Future.value(true);
      }
    }else{
      print("=========3${root}upload");
    }

    return Future.value(false);
  }

  static final httpClient = dio.Dio();

  static Future<List<FileItem>> listSync({required String path_}) async {
    var response =
        await httpClient.get("${root}files", queryParameters: {"Path": path_});
    List<dynamic> list = response.data;
    List<FileItem> fileItemList =
        list.map((e) => FileItem.fromJson(e)).toList();
    return fileItemList;
  }
}
