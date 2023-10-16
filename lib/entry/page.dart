import 'package:file_manager/entry/path.dart';
import 'package:file_manager/util/json.dart';

class ExPage<T> {
  ExPage({
    this.total,
    this.list,
  });

  int? total;
  List<T>? list;

  static ExPage<ExPath> fromPathJson(Map<String, dynamic> json) {
    var exPage = ExPage<ExPath>();
    exPage.total = Json.getInt(json, "total");

    exPage.list = ExPath.fromListJson(Json.getListDynamic(json, "list"));
    return exPage;
  }
}
