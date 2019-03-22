import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();、
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new RandomWord(),
      theme: new ThemeData(
          appBarTheme: new AppBarTheme(color: Colors.blueAccent,
              iconTheme: new IconThemeData(color: Colors.white))),
    );
  }
}

class RandomWord extends StatefulWidget {
  @override
  createState() => new RandomWordState();
}

class RandomWordState extends State<RandomWord> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "列表",
          style: new TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return new Divider(color: new Color(0x55999999));
      final index = i ~/ 2;

      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _saved.contains(wordPair);
    return new ListTile(
      title: new Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final titles = _saved.map((wordPair) {
        return new ListTile(
            title: new Text(
              wordPair.asPascalCase,
              style: _biggerFont,
            ));
      });

      final child = ListTile.divideTiles(context: context, tiles: titles)
          .toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "收藏列表",
            style: new TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: new ListView(
          children: child,
        ),
      );
    }));
  }
}
