import 'package:flutter/material.dart';
import './ad_factory.dart';
import './ad_provider.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;

  AdService._internal();

  int _adCounter = 0;

  Widget getBannerAd() {
    final adProvider = _getAdProvider();
    return adProvider.getBannerAdWidget();
  }

  Widget getNativeAd() {
    final adProvider = _getAdProvider();
    return adProvider.getNativeAdWidget();
  }

  AdProvider _getAdProvider() {
    _adCounter++;
    if (_adCounter % 2 == 0) {
      return AdFactory.getAdProvider(AdNetwork.GOOGLE);
    } else {
      return AdFactory.getAdProvider(AdNetwork.META);
    }
  }
}
