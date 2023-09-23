import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import '../component/ex_dialog.dart';
import '../entry/Info.dart';
import '../entry/file.dart';
import 'package:dio/dio.dart' as dio;

import '../entry/response.dart';

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

  static Future<Response> addAdminUser(BuildContext context,
      {required String username,
      required String password,
      required String rePassword,
      required bool isNatClient,
      required bool isNatServer})  async {
    var url = "${root}addAdmin";
    var postData = {
      "username":username,
      "password": password,
      "rePassword": rePassword,
      "isNatClient": isNatClient,
      "isNatServer": isNatServer
    };
    var response = await httpClient.post(url,data: postData);
    var data = response.data;
    var res = Response.fromJson(data);
    return res;
  }
}
