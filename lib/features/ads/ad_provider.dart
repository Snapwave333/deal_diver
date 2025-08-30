import 'package:flutter/material.dart';

abstract class AdProvider {
  Widget getBannerAdWidget();
  Widget getNativeAdWidget();
}
