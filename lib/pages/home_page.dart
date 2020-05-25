// import 'dart:js';

import 'package:color_game/models/user.dart';
import 'package:color_game/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //  final int bestScore;
  // User user;

  Widget _buildSquare(BuildContext context) {
    return Container(
      height: 300,
      // height: MediaQuery.of(context).size.width,
      child: GridView.count(
        physics: ScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: 75,
          left: 75,
          right: 75,
          top: 40,
        ),
        crossAxisCount: 3,
        children: List.generate(
          3 * 3,
          (index) => _buildColorBox(index, context),
        ),
      ),
      // constraints: BoxConstraints(maxHeight: 100),
    );
  }

  Widget _buildColorBox(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: index == 4 ? Colors.red : Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        isInGamePage: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'DIFFERENT',
              style: TextStyle(color: Colors.white, fontSize: 52),
            ),
            Text(
              'COLOR',
              style: TextStyle(color: Colors.white, fontSize: 42),
            ),
            _buildSquare(context),
          ],
        ),
      ),
    );
  }
}
