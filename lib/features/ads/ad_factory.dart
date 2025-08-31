import './ad_provider.dart';
import './google_ad_provider.dart';

enum AdNetwork { GOOGLE }

class AdFactory {
  static AdProvider getAdProvider(AdNetwork adNetwork) {
    switch (adNetwork) {
      case AdNetwork.GOOGLE:
        return GoogleAdProvider();
      default:
        throw Exception('Invalid ad network');
    }
  }
}
