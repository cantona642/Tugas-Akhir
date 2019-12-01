import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'map_view.dart';

const API_KEY = "AIzaSyDp-x54CkbpwRxOn4g-IALcuGC7YFbpOhU";

void main(){
  MapView.setApiKey(API_KEY);
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}