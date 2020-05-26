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
        margin: EdgeInsets.only(top: 50),
        // height: 300,
        // height: MediaQuery.of(context).size.width-70,
        height: 250,
        width: 320,
        // width: MediaQuery.of(context).size.width-70,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildColorBox(0, context),
                    _buildColorBox(1, context),
                    _buildColorBox(2, context),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildColorBox(3, context),
                    _buildColorBox(4, context),
                    _buildColorBox(5, context),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildColorBox(6, context),
                    _buildColorBox(7, context),
                    _buildColorBox(8, context),
                  ],
                ),
              ),
            ],
          ),
        )
        // constraints: BoxConstraints(maxHeight: 100),
        );
  }

  Widget _buildColorBox(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),

      child: Container(
        width: MediaQuery.of(context).size.width / 4,
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
