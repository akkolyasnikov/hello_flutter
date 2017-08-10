import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';

void main (){
  runApp(
    new MaterialApp(
      home: new ArticleView()
    )
  );
}




class ArticleView extends StatefulWidget{
  @override
  ArticleViewState createState() => new ArticleViewState();
}

class ArticleViewState extends State<ArticleView>{
  int _articleCur = 1;
  String _articleHead = "Здесь будет статья";
  String _articleContent = "";

  Future<Map> _nextArticle() async{
    if(_articleCur<100){_articleCur++;}else{_articleCur=1;}
    var httpClient = createHttpClient();
    String url = 'http://jsonplaceholder.typicode.com/posts/'+_articleCur.toString();
    var responce = await httpClient.read(url);
    return JSON.decode(responce);
  }
  Future<Map> _prevArticle() async{
    if(_articleCur>0){_articleCur--;}else{_articleCur=100;}
    var httpClient = createHttpClient();
    String url = 'http://jsonplaceholder.typicode.com/posts/'+_articleCur.toString();
    var responce = await httpClient.read(url);
    return JSON.decode(responce);
  }


  void onPressed(bool direction){
    if(direction) {
      _nextArticle().then((Map articleRaw) {
        setState(() {
          _articleHead = articleRaw['title'];
          _articleContent = articleRaw['body'];
        });
      });
    }
    else {
      _prevArticle().then((Map articleRaw) {
        setState(() {
          _articleHead = articleRaw['title'];
          _articleContent = articleRaw['body'];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Приветствие")),
      body: new Container(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child:new Column (
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new RaisedButton(
                    child: new Text("Преедыю"),
                    color: Colors.lightBlue,
                    highlightColor: Colors.lightBlueAccent,
                    onPressed: (){onPressed(false);},
                  ),
                  new RaisedButton(
                    child: new Text(_articleCur.toString()),
                    color: Colors.lightBlue,
                    highlightColor: Colors.lightBlueAccent,
                    onPressed: (){onPressed(false);},
                  ),
                  new RaisedButton(
                    child: new Text("Следующая"),
                    color: Colors.lightBlue,
                    highlightColor: Colors.lightBlueAccent,
                    onPressed: (){onPressed(true);},
                  )
                ]
              ),
              new Container(
                width:250.0,
                child: new Center(
                  child:new Text(
                    _articleHead,
                    style: new TextStyle(
                      fontWeight: FontWeight.w900,
                    )
                  )
                )
              ),
              new Text(_articleContent)
            ]
          )
        )
      ),
    );
  }
}

