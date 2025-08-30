import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import './ad_provider.dart';

class GoogleAdProvider implements AdProvider {
  @override
  Widget getBannerAdWidget() {
    final bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ad unit ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    )..load();

    return Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }

  @override
  Widget getNativeAdWidget() {
    final nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // Test ad unit ID
      factoryId: 'adFactoryExample',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    )..load();

    return SizedBox(
      width: double.infinity,
      height: 320,
      child: AdWidget(ad: nativeAd),
    );
  }
}
