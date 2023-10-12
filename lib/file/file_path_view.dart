
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entry/file.dart';
import 'file_mange.dart';

class FilePathView extends StatefulWidget {
  const FilePathView({super.key});

  @override
  State<StatefulWidget> createState() => _FilePathViewState();
}

class _FilePathViewState extends State<FilePathView> {
  @override
  Widget build(BuildContext context) {
    var items = Provider.of<FilePageDelegate>(context).items;
    final List<Widget> children = <Widget>[
      for (var pathItem in items) Text("${pathItem.name}>")
    ];

    var hasBack = Provider.of<FilePageDelegate>(context).hasBack;
    var hasForward = Provider.of<FilePageDelegate>(context).hasForward;
    return Row(
      children: <Widget>[
        IconButton(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          icon: const Icon(Icons.arrow_back_ios),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: !hasBack
              ? null
              : () {
            PathItem pathItem =
                Provider.of<FilePageDelegate>(context, listen: false)
                    .backItems;
            loadFileAsset(context, pathItem.path, true);
          },
        ),
        SizedBox(
            width: 40,
            child: IconButton(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              highlightColor: Colors.white,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !hasForward
                  ? null
                  : () {
                PathItem pathItem =
                    Provider.of<FilePageDelegate>(context, listen: false)
                        .forwardItems;
                loadFileAsset(context, pathItem.path, true);
              },
            )),
        Row(
          children: children,
        )
      ],
    );
  }
}