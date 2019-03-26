import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main() => runApp(new AsyncDemo());

class AsyncDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AsyncDemoPage();
  }
}

class AsyncDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AsyncDemoPageState();
  }
}

class AsyncDemoPageState extends State<AsyncDemoPage> {
  List dataList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Async demo",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("AsyncDemo"),
          centerTitle: true,
        ),
        body: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return new ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider(color: new Color(0x55999999));
        }
        return _buildItem(i);
      },
      itemCount: dataList.length,
      padding: EdgeInsets.all(10.0),
    );
  }

  Widget _buildItem(int pos) {
    var item = dataList[pos ~/ 2];
    var title = item["title"];
    return new Text(title);
  }

  void loadData() async {
    String dataUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataUrl);
    setState(() {
      dataList = json.decode(response.body);
    });
  }
}