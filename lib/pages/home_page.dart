// import 'dart:js';

import 'package:color_game/pages/game_page.dart';
import 'package:color_game/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

class HomePage extends StatefulWidget {
  // _HomePageState({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

const String testDevice = 'YOUR_DEVICE_ID';

class _HomePageState extends State<HomePage> {
  BannerAd _bannerAd;

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: testDevice != null ? <String>[testDevice] : null,
  );
  // FirebaseAdMob.instance.initialize(appId: appId);
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-9186350757856519/5566501033');
    _bannerAd = createBannerAd()..load();
    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  //  final int bestScore;
  // User user;

  Widget _buildSquare(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 17),
        // height: 300,
        // height: MediaQuery.of(context).size.width-70,
        height: 250,
        width: 310,
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
        // height: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: index == 4 ? Colors.red : Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
    );
  }

  Widget _playButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
        height: MediaQuery.of(context).size.height / 11,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Center(
          child: Text(
            'PLAY GAME',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
          borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width / 10)),
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GamePage()));
        _bannerAd?.dispose();
        _bannerAd = null;
      },
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
            _playButton(context),
          ],
        ),
      ),
    );
  }
}
