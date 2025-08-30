import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:provider/provider.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/app/app.dart';
import 'package:myapp/features/iap/in_app_purchase_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  FacebookAudienceNetwork.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => InAppPurchaseProvider(),
      child: const MyApp(),
    ),
  );
}
