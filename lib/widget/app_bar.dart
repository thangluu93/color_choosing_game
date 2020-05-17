import 'package:color_game/models/user.dart';
import 'package:color_game/pages/game_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final int bestScore;
  final bool isInGamePage;
  final Function onPressRestart;
  User user = new User();

  GamePage gamePage = GamePage();
  NavBar({
    this.bestScore,
    this.onPressRestart,
    this.isInGamePage,
  });

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  
        actions: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
          refreshIcon(context)
        ],
        title: best(),
        // backgroundColor: Colors.colorChosing,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  refreshIcon(BuildContext context) {
    if (isInGamePage) {
      return IconButton(
        icon: Icon(
          Icons.refresh,
          color: Colors.white,
          size: 30,
        ),
        onPressed: onPressRestart,
      );
    } else {
      return Container(
        width: 10,
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(70);

  best() {
    if (isInGamePage) {
      return Center(
        child: Text(
          'BEST: $bestScore',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container();
    }
  }
}
