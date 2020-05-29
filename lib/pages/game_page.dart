import 'dart:async';
import 'dart:math' as math;
import 'package:color_game/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:color_game/widget/dialog.dart';
import 'package:color_game/widget/app_bar.dart';
import 'package:firebase_admob/firebase_admob.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

const String testDevice = 'YOUR_DEVICE_ID';

class _GamePageState extends State<GamePage> {
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

  BannerAd _bannerAd;
  bool _gameOver = false;

  int _seconds = 20;
  int _score = 1;
  int _bestScore = 1;

  int _crossAxisCount = 3;
  bool _pressRestart = false;
  int _diffIndex;
  Color _diffColor;
  Color _color;

  _GamePageState();

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

    _updateData();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  void _updateData() async {
    final crossAxisCount = math.min(4, ((_score + 5) / 2).floor());

    final rand = math.Random();
    final diffIndex = rand.nextInt(crossAxisCount * crossAxisCount);
    final color = Color((math.Random().nextDouble() * 0xFFFFFFFF).toInt() << 0)
        .withOpacity(1);
    final diffColor = color.withOpacity(math.min(0.95, 0.6 + _score / 100));

    var prefs = await SharedPreferences.getInstance();
    var bestScore = prefs.getInt('BEST') ?? 1;

    if (bestScore < _score) {
      await prefs.setInt('BEST', _score);
      bestScore = _score;
    }
    // _bannerAd = createBannerAd()..load();
    // _bannerAd ??= createBannerAd();
    // _bannerAd
    //   ..load()
    //   ..show();

    setState(() {
      _diffIndex = diffIndex;
      _color = color;
      _diffColor = diffColor;
      _crossAxisCount = crossAxisCount;
      _bestScore = bestScore;
    });
    new User(bestScore: _bestScore);
  }

  void _restart() {
    setState(() {
      _gameOver = false;
      _score = 1;
      _seconds = 20;
    });

    _updateData();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  void _onRestartPress() {
    _restart();
    // _gameOver = true;
    _pressRestart = true;
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  void _setGameOver() async {
    if (!_pressRestart) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          score: _score,
        ),
      );
    }
    _restart();
    // _gameOver = true;
    _updateData();

  }

  void _setTimer() {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        if (_seconds <= 0 || _pressRestart) {
          t.cancel();
          _setGameOver();
        } else {
          setState(() {
            _seconds = _seconds - 1;
          });
        }
      },
    );
  }

  void _onColorPressed(int index) {
    if (_score == 1 && _seconds == 20) {
      _gameOver = false;
      _pressRestart = false;
      _setTimer();
    }
    if (!_gameOver) {
      if (index == _diffIndex) {
        _updateData();
        setState(() {
          _score = _score + 1;
          _seconds = _seconds + 1;
        });
      } else {
        if (_seconds >= 3) {
          setState(() {
            _seconds = _seconds - 3;
          });
        }
      }
    }
  }

  Widget _buildToolbar() {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: InkWell(
              // onTap: _onTimePressed,
              child: Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  _seconds.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'SCORE',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _score.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'BEST',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _bestScore.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquare() {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: GridView.count(
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(15),
        crossAxisCount: _crossAxisCount,
        children: List.generate(
          _crossAxisCount * _crossAxisCount,
          (index) => _buildColorBox(index),
        ),
      ),
    );
  }

  Widget _buildColorBox(int index) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: RaisedButton(
        color: index != _diffIndex ? _color : _diffColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(60),
          ),
        ),
        onPressed: () {
          _onColorPressed(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        bestScore: _bestScore,
        isInGamePage: true,
        onPressRestart: _onRestartPress,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildToolbar(),
            _buildSquare(),
          ],
        ),
      ),
    );
  }
}
