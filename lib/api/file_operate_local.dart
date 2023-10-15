import 'dart:async';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'dart:developer' as developer;
import '../entry/file.dart';

class FileOperateLocal {
  static String root = "C:/Users/cooge/Pictures/";

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
        stat.modified,
        false)));
    return fList2.toList();
  }

  static Future<List<FileItem>> listSync({required String path_}) async {
    if (path_.startsWith("/") || path_.startsWith("\\")) {
      path_ = path_.substring(1);
    }
    var absolutePath = path.join(root, path_);
    var dir = io.Directory(absolutePath);
    List<io.FileSystemEntity> list = dir.listSync();
    var fList2 = list.map((file) => (stat: file.statSync(), file: file)).map(
        (info) => FileItem(
            path.basename(info.file.path),
            path.relative(info.file.path, from: root),
            info.stat.type == io.FileSystemEntityType.directory,
            (info.stat.type == io.FileSystemEntityType.directory)
                ? 0
                : info.stat.size,
            info.stat.modified,
            false));
    return fList2.toList();
  }

  static Future<bool> createNewFolder(
      {required String path_, required String folder}) async {
    if (path_.startsWith("/") || path_.startsWith("\\")) {
      path_ = path_.substring(1);
    }
    if (folder.startsWith("/") || folder.startsWith("\\")) {
      folder = folder.substring(1);
    }
    var absolutePath = path.join(root, path_, folder);
    var dir = io.Directory(absolutePath);
    bool exists = await dir.exists();
    if (!exists) {
      dir.createSync(recursive: true);
      return true;
    }
    return false;
  }

  static Future<bool> uploadNewFile(
      {required String path_,
      required io.File file,
      ProgressCallback? progressCallback}) {
    if (path_.startsWith("/") || path_.startsWith("\\")) {
      path_ = path_.substring(1);
    }
    var name = path.basename(file.path);
    var absolutePath = path.join(root, path_, name);
    var logFile = io.File(absolutePath);
    if (logFile.existsSync()) {
      logFile.deleteSync();
    }
    Completer<bool> completer = Completer();
    Stream<List<int>> inputStream = file.openRead();
    inputStream.listen((event) {
      logFile.writeAsBytesSync(event, mode: io.FileMode.append, flush: true);
    }, onDone: () {
      completer.complete(true);
    }, onError: (_) {
      completer.complete(false);
    });
    return completer.future;
  }

  static Future<bool> downloadFile(
      {required FileItem fileItem,
      required localPath,
      ProgressCallback? progressCallback}) {
    var path_ = fileItem.path;
    if (path_.startsWith("/") || path_.startsWith("\\")) {
      path_ = path_.substring(1);
    }
    var absolutePath = path.join(root, path_);
    var file = io.File(absolutePath);
    var logFile = io.File(localPath);
    Stream<List<int>> inputStream = file.openRead();
    Completer<bool> completer = Completer();
    inputStream.listen((event) {
      logFile.writeAsBytesSync(event, mode: io.FileMode.append, flush: true);
    }, onDone: () {
      completer.complete(true);
    }, onError: (_) {
      completer.complete(false);
    });
    return completer.future;
  }
}
