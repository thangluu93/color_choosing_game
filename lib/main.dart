import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:color_game/pages/home_page.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AssetsAudioPlayer _assetsAudioPlayer;

  @override
  void initState() {
    super.initState();

    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.open(Audio("assets/music.mp3"));
    _assetsAudioPlayer.playOrPause();
  }

  @override
  void dispose() {
    _assetsAudioPlayer = null;
    super.dispose();
  }

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
