
import 'package:color_game/pages/game_page.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
        // backgroundColor: Colors.colorChosing,
        scaffoldBackgroundColor: Colors.colorChosing,
      ),
      home: GamePage(),
    );
  }
}

