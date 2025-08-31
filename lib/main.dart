import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/app/app.dart';
import 'package:myapp/features/iap/in_app_purchase_provider.dart';
import 'package:myapp/services/remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfigService.instance.initialize();
  MobileAds.instance.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => InAppPurchaseProvider(),
      child: const MyApp(),
    ),
  );
}
