import 'package:file_manager/entry/page.dart';
import 'package:file_manager/entry/path.dart';
import 'package:file_manager/util/json.dart';

class Response<T> {
  Response({this.code, this.data});

  int? code;
  T? data;

  bool isOK() {
    return code == 200;
  }

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        code: Json.getInt(json, "code"), data: Json.getDynamic(json, "data"));
  }

  static Response<ExPage<ExPath>> fromJsonToPathPage(Map<String, dynamic> json) {
    var page = Response<ExPage<ExPath>>();
    page.code = Json.getInt(json, "code");
    page.data = ExPage.fromPathJson(Json.getDynamic(json, "data"));
    return page;
  }
}
