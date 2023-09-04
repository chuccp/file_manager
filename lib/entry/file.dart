import 'package:path/path.dart' as path2;



class FileItem {
  FileItem(this.name, this.path, this.isDir, this.size, this.modifyTime);

  final bool isDir;
  final String name;
  final String path;
  final int size;
  final DateTime modifyTime;

  factory FileItem.fromJson(Map<String, dynamic> json) {
    DateTime modify = DateTime.now();
    if (json.containsKey('modifyTime')) {
      int modifyTime = json['modifyTime'];
      modify = DateTime.fromMillisecondsSinceEpoch(modifyTime);
    }
    bool isDir = false;
    if (json.containsKey('isDir')) {
      isDir = json['isDir'];
    }
    int size = 0;
    if (json.containsKey('size')) {
      size = json['size'];
    }
    String path = "";
    if (json.containsKey('path')) {
      path = json['path'];
    }

    return FileItem(json['name'], path, isDir, size, modify);
  }
}

class PathItem {
  PathItem(this.path, this.name);

  final String path;
  final String name;

  static List<PathItem> splitPath(String path_) {
    path_ = path_.trim();
    if (path_.startsWith("/") || path_.startsWith("\\")) {
      path_ = path_.substring(1);
    }
    List<PathItem> pathItems = [PathItem("\\", "我的空间")];
    path_ = path_.replaceAll("\\", "/");
    if (path_.isNotEmpty) {
      List<String> paths = path2.split(path_);
      var pathTemp = "";
      for (var path in paths) {
        pathTemp = "$pathTemp\\$path";
        pathItems.add(PathItem(pathTemp, path));
      }
    }
    return pathItems;
  }
}

void main() {
  List<PathItem> pathItems = PathItem.splitPath("aaa/aaa/aaa");
  for (var item in pathItems) {

  }
}
