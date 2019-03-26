import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "anim test",
      home: new FadeTest("a"),
      routes: <String, WidgetBuilder>{
        "a": (context) {
          return new FadeTest("a");
        },
        "b": (context) {
          return new FadeTest("b");
        },
        "c": (context) {
          return new FadeTest("c");
        }
      },
    );
  }
}

class FadeTest extends StatefulWidget {
  String _pageName;

  FadeTest(String name) {
    _pageName = name;
  }

  @override
  State<StatefulWidget> createState() {
    return new FadeState(_pageName);
  }
}

class FadeState extends State<FadeTest> with TickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  String _pageName = "";

  FadeState(String pageName) {
    _pageName = pageName;
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _curvedAnimation =
    new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Center(
            child: new Text("anim " + _pageName),
          )
      ),
      body: new Center(
        child: new Container(
          child: new FadeTransition(
            opacity: _curvedAnimation,
            child: new FlutterLogo(size: 100,),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _controller.forward();
          Navigator.of(context).pushNamed("b");
        },
        tooltip: "fade",
        child: new Icon(Icons.brush),
      ),
    );
  }
}