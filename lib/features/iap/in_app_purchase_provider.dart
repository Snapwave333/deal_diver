import 'package:flutter/material.dart';
import './in_app_purchase_service.dart';

class InAppPurchaseProvider with ChangeNotifier {
  final InAppPurchaseService _inAppPurchaseService = InAppPurchaseService();
  
  bool _isAdFree = false;
  bool get isAdFree => _isAdFree;

  InAppPurchaseProvider() {
    _inAppPurchaseService.init().then((_) {
      _isAdFree = _inAppPurchaseService.isAdFree;
      notifyListeners();
    });
  }

  void buyAdFreeUnlock() {
    _inAppPurchaseService.buyAdFreeUnlock();
  }
}
