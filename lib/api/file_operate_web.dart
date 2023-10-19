import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import '../entry/file.dart';
import 'package:dio/dio.dart' as dio;

class FileOperateWeb {

  static String root = "http://127.0.0.1:2156/file/";



  static Future<bool> uploadNewFile(
      {required String rootPath,required String path_,
      required FilePickerResult? pickerResult,
      required dio.ProgressCallback progressCallback}) async {
    PlatformFile? platformFile = pickerResult?.files.first;
    if (platformFile != null ) {
      final formData = dio.FormData.fromMap({
        'Path': path_,
        "RootPath":rootPath,
        'file': dio.MultipartFile.fromStream(
            () =>platformFile.readStream!, platformFile.size,
            filename: platformFile.name)
      });
      var response = await httpClient.post("${root}upload", data: formData,onSendProgress:progressCallback);
      if (response.statusCode == 200) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }

  static final httpClient = dio.Dio();

  static Future<List<FileItem>> listSync({required String rootPath,required String path_}) async {
    var response = await httpClient.get("${root}files", queryParameters: {"Path": path_,"RootPath":rootPath});
    List<dynamic> list = response.data;
    List<FileItem> fileItemList =
        list.map((e) => FileItem.fromJson(e)).toList();
    return fileItemList;
  }


  static Future<List<FileItem>> rootListSync() async {
    var response = await httpClient.get("${root}root");
    List<dynamic> list = response.data;
    List<FileItem> fileItemList =
    list.map((e) => FileItem.fromJson(e)).toList();
    return fileItemList;
  }
  static Future<List<FileItem>> pathListSync({required String path_}) async {
    var response = await httpClient.get("${root}paths", queryParameters: {"Path": path_});
    List<dynamic> list = response.data;
    List<FileItem> fileItemList =
    list.map((e) => FileItem.fromJson(e)).toList();
    return fileItemList;
  }
}
