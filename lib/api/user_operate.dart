import 'dart:convert';
import 'dart:io' as io;
import 'package:download/download.dart';
import 'package:file_manager/entry/page.dart';
import 'package:file_manager/entry/path.dart';
import 'package:file_manager/util/download.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../component/ex_dialog.dart';
import '../entry/info.dart';
import '../entry/file.dart';
import 'package:dio/dio.dart' as dio;

import '../entry/response.dart';
import '../util/local_store.dart';
import 'httpclient.dart';

class UserOperateWeb {
  static String root = "http://127.0.0.1:2156/user/";

  static final httpClient = dio.Dio();

  static Future<InfoItem> info() async {
    var url = "${root}info";
    var response = await httpClient.get(url, options: await getOptions());
    var data = response.data;
    var infoItem = InfoItem.fromJson(data);
    return infoItem;
  }

  static Future<Response> addAdminUser(
      {required String username,
      required String password,
      required String rePassword,
      required bool isNatClient,
      required bool isNatServer}) async {
    var url = "${root}addAdmin";
    var postData = {
      "username": username,
      "password": password,
      "rePassword": rePassword,
      "isNatClient": isNatClient,
      "isNatServer": isNatServer
    };
    var response = await httpClient.post(url,
        data: jsonEncode(postData), options: await getOptions());
    var data = response.data;
    var res = Response.fromJson(data);
    return res;
  }

  static Future<Response> signIn(
      {required String username, required String password}) async {
    var url = "${root}signIn";
    var postData = {
      "username": username,
      "password": password,
    };
    var response = await httpClient.post(url,
        data: jsonEncode(postData), options: await getOptions());
    var data = response.data;
    var res = Response.fromJson(data);
    return res;
  }

  static Future<Response> connect({required String address}) async {
    var url = "${root}connect?address=$address";
    var response = await httpClient.get(url);
    var data = response.data;
    var res = Response.fromJson(data);
    return res;
  }

  static Future<Response> addPath(
      {required String name, required String path}) async {
    var url = "${root}addPath";
    var postData = {
      "name": name,
      "path": path,
    };
    var response = await httpClient.post(url,
        data: jsonEncode(postData), options: await getOptions());
    var data = response.data;
    var res = Response.fromJson(data);
    return res;
  }

  static Future<Response<ExPage<ExPath>>> queryPath(
      {required int pageNo, required int pageSize}) async {
    var url = "${root}queryPath?pageNo=$pageNo&pageSize=$pageSize";
    var response = await httpClient.get(url, options: await getOptions());
    var data = response.data;
    var res = Response.fromJsonToPathPage(data);
    return res;
  }


  static Future<Response<ExPage<ExPath>>> queryAllPath() async {
    var url = "${root}queryAllPath";
    var response = await httpClient.get(url, options: await getOptions());
    var data = response.data;
    var res = Response.fromJsonToPathPage(data);
    return res;
  }


  static Future<Response> addRemoteAddress(
      {required List<String> address}) async {
    var url = "${root}addRemoteAddress";
    var response = await httpClient.post(url,
        data: jsonEncode(address), options: await getOptions());
    var data = response.data;
    var res = Response.fromJson(data);
    return res;
  }

  static Future<void> downloadCert() async {
    String? token = await LocalStore.getToken();
    var url = "${root}downloadCert?token=$token";
    downloadUrl(url);
  }
}
