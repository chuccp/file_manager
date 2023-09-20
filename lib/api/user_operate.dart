import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import '../entry/Info.dart';
import '../entry/file.dart';
import 'package:dio/dio.dart' as dio;

class UserOperateWeb {

  static String root = "http://127.0.0.1:2156/user/";

  static final httpClient = dio.Dio();
  static Future<InfoItem> info() async {
    var url = "${root}info";
    var response = await httpClient.get(url);
    var data = response.data;
    var infoItem = InfoItem.fromJson(data);
    return infoItem;
  }
}
