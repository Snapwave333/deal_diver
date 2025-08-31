import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:developer' as developer;

class RemoteConfigService {
  RemoteConfigService._();
  static final instance = RemoteConfigService._();

  final _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await _remoteConfig.setDefaults(const {
        "promotional_banner_enabled": false,
      });
      await _remoteConfig.fetchAndActivate();
    } catch (e, s) {
      developer.log(
        'Remote Config fetch failed',
        name: 'com.dealdiver.remoteconfig',
        error: e,
        stackTrace: s,
      );
    }
  }

  bool get isPromotionalBannerEnabled =>
      _remoteConfig.getBool("promotional_banner_enabled");
}
