import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class AdMobAds {
  static const appId = "ca-app-pub-3519080576365340~1820185924";
  static const bannerId = "ca-app-pub-3519080576365340/2941695905";

  static Widget ad;

  static init() {
    Admob.initialize(appId);
    ad = AdmobBanner(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
    );
  }
}
