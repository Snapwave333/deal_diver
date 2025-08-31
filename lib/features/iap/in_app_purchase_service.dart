import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseService {
  static final InAppPurchaseService _instance = InAppPurchaseService._internal();
  factory InAppPurchaseService() => _instance;

  InAppPurchaseService._internal();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final Set<String> _productIds = {'ad_free_unlock'};
  List<ProductDetails> _products = [];
  bool _isAdFree = false;

  bool get isAdFree => _isAdFree;

  Future<void> init() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });

    await _loadProducts();
    await _restorePurchases();
  }

  Future<void> _loadProducts() async {
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_productIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    _products = response.productDetails;
  }

  Future<void> _restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  void buyAdFreeUnlock() {
    try {
      final ProductDetails productDetails = _products.firstWhere((product) => product.id == 'ad_free_unlock');
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      // Product not found, handle gracefully
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Handle pending purchases.
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // Handle errors.
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.productID == 'ad_free_unlock') {
            _isAdFree = true;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
