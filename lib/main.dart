import 'package:flutter/material.dart';
import 'package:movietime_app/ui/HomePageTopBar.dart';

void main() => runApp(new MovieTimeHomePage());

class MovieTimeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Movie Time",
      theme: new ThemeData(
        primaryColor: Colors.blueAccent
      ),
      home: new HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new HomePageTopBar("Cinema"),
    );
  }
}