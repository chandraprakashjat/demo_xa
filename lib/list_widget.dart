import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/my_item.dart';
import 'package:http/http.dart' as http;

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  State<ListWidget> createState() => _State();
}

class _State extends State<ListWidget> {
  late List<MyItem> itemList = [];

  @override
  void initState() {
    super.initState();

    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text('${itemList[index].title}'),
        );
      }),
      itemCount: itemList.length,
    ));
  }

  void getList() async {
    http.Response response = await http.get(
        Uri.parse('https://my-json-server.typicode.com/typicode/demo/posts'));

    if (response.statusCode == 200) {
      var dataList = MyItem.fromJson(jsonDecode(response.body)) as List;

      itemList = dataList.map((item) => MyItem.fromJson(item)).toList();

      setState(() {});
    } else {}
  }
}
