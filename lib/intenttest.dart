import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() => runApp(new IntentApp());

class IntentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "intent test",
      home: new IntentAppPage(),
    );
  }
}

class IntentAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _IntentAppPageState();
  }
}

class _IntentAppPageState extends State<IntentAppPage> {
//  static const platform = const MethodChannel("app.channel.shared.data");
  String _sharedText = "no data";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Intent Msg"),
        centerTitle: true,
      ),
      body: new Center(
        child: new Text(_sharedText),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          print("onPressed");
          callAndroidMethod();
        },
        child: new Icon(Icons.add),
      ),
    );
  }

  void callAndroidMethod() async {
    var channel = MethodChannel("app.channel.shared.data");
    var result = await channel.invokeMethod("startIntentCall");
    print("result: " + result.toString());
    if (result != null) {
      setState(() {
        _sharedText = "callTimes: " + result.toString();
      });
    }
  }
}