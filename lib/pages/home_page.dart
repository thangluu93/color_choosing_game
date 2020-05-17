
import 'package:color_game/models/user.dart';
import 'package:color_game/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  
  int bestScore;
  User user;
  




  @override 
  Widget build(BuildContext context){
    return Scaffold(appBar: NavBar(isInGamePage: false,),);
}}

