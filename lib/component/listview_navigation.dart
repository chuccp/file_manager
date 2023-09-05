import 'package:flutter/material.dart';

class ListviewWithNavigation extends StatelessWidget {
  const ListviewWithNavigation({super.key});



  @override
  Widget build(BuildContext context) {

    WidgetBuilder? body;

    final List<String> entries = <String>['下载中', '上传中', '已完成'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return  Row(
      children: <Widget>[
        SizedBox(
          width: 120,
          child:  ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return  InkWell(onTap: (){}, child:SizedBox(
                height: 50,
                width: 20,
                // color: Colors.amber[colorCodes[index]],
                child:  Center(child:  Text(entries[index])),
              ));
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        ),
         Expanded(
          child: Builder(builder: (BuildContext context)=>const Text('测试', textAlign: TextAlign.center),),
        ),
      ],
    );
  }
}
