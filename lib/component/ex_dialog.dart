


import 'package:flutter/material.dart';

Future<bool?> alertDialog({required BuildContext context,required String msg}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("提示"),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: const Text("确认"),
            onPressed: () {
              //关闭对话框并返回true
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
typedef VoidCallback = Future<bool> Function();

Future<bool?> exShowDialog({required BuildContext context,required VoidCallback onPressed,Widget? title,Widget? content}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            child: const Text("确认"),
            onPressed: () {

              onPressed().then((value){
                if(value){
                  Navigator.of(context).pop(true);
                }
              });
            },
          ),
        ],
      );
    },
  );
}