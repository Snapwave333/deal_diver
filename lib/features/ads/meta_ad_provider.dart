import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import './ad_provider.dart';

class MetaAdProvider implements AdProvider {
  @override
  Widget getBannerAdWidget() {
    return FacebookBannerAd(
      placementId: 'YOUR_PLACEMENT_ID', // Replace with your own placement ID
      bannerSize: BannerSize.STANDARD,
    );
  }

  @override
  Widget getNativeAdWidget() {
    return FacebookNativeAd(
      placementId: "YOUR_PLACEMENT_ID", // Replace with your own placement ID
      adType: NativeAdType.NATIVE_AD,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
    );
  }
}
