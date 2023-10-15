import 'package:dio/dio.dart';

import '../util/local_store.dart';

Future<Options> getOptions() async {
  Map<String, dynamic> httpHeaders = {};
  String? token = await LocalStore.getToken();
  if (token != null) {
    httpHeaders["token"] = token;
  }
  return Options(headers: httpHeaders);
}
