import 'dart:async';
import 'package:flutter/material.dart';
import '../models/deal.dart';
import '../repositories/deal_repository.dart';

class DealProvider with ChangeNotifier {
  final DealRepository _dealRepository;
  late final Stream<List<Deal>> _dealsStream;

  DealProvider(this._dealRepository) {
    _dealsStream = _dealRepository.getDeals();
  }

  Stream<List<Deal>> get dealsStream => _dealsStream;

  Future<void> addDeal(Deal deal) async {
    await _dealRepository.addDeal(deal);
  }

  Future<void> updateDeal(Deal deal) async {
    await _dealRepository.updateDeal(deal);
  }

  Future<void> deleteDeal(String id) async {
    await _dealRepository.deleteDeal(id);
  }
}
