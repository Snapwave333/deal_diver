import 'package:flutter/material.dart';
import '../models/deal.dart';
import '../repositories/deal_repository.dart';

class DealProvider with ChangeNotifier {
  final DealRepository _dealRepository;

  List<Deal> _deals = [];
  bool _isLoading = false;

  DealProvider(this._dealRepository) {
    fetchDeals();
  }

  List<Deal> get deals => _deals;
  bool get isLoading => _isLoading;

  Future<void> fetchDeals() async {
    _isLoading = true;
    notifyListeners();
    _deals = await _dealRepository.getDeals();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addDeal(Deal deal) async {
    await _dealRepository.addDeal(deal);
    await fetchDeals();
  }

  Future<void> updateDeal(Deal deal) async {
    await _dealRepository.updateDeal(deal);
    await fetchDeals();
  }

  Future<void> deleteDeal(String id) async {
    await _dealRepository.deleteDeal(id);
    await fetchDeals();
  }
}
