import './ad_provider.dart';
import './google_ad_provider.dart';
import './meta_ad_provider.dart';

enum AdNetwork { GOOGLE, META }

class AdFactory {
  static AdProvider getAdProvider(AdNetwork adNetwork) {
    switch (adNetwork) {
      case AdNetwork.GOOGLE:
        return GoogleAdProvider();
      case AdNetwork.META:
        return MetaAdProvider();
      default:
        throw Exception('Invalid ad network');
    }
  }
}
