import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExScaffold extends StatelessWidget {
  const ExScaffold({super.key, required this.title, this.body});

  final String title;

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()  {
            if (Navigator.of(context).canPop()) {Navigator.pop(context,true);}
          },
        ),
      ),
      body: body,
    );
  }
}
