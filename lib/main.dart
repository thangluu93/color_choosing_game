

import 'package:color_game/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  User user ;
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
        // backgroundColor: Colors.colorChosing,
        scaffoldBackgroundColor: Color(0xFF292234),
      ),
      home: HomePage(),
    );
  }
}

