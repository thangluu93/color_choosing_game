import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final int score;
  CustomDialog(
   {  this.score,}
  );
  @override
  State<StatefulWidget> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
int score1;
  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: 'ca-app-pub-9186350757856519/2412696416',
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    score1=widget.score;
     _interstitialAd = createInterstitialAd()..load();

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    var text = Text(
      'Better luck next time!!!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.0,
      ),
    );

    loadAd() async {
      // _interstitialAd?.dispose();
     
     await  _interstitialAd.show().then((value) =>  Navigator.of(context).pop());
    
    }

    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  'Your level is $score1',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                text,
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Icon(
                      Icons.refresh,
                      size: 50,
                    ),
                    onTap: () {
                      loadAd();
                      
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Consts.avatarRadius,
              backgroundImage: AssetImage('assets/gift.gif'),
            ),
          ),
        ],
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
