import '../models/deal.dart';
import './firestore_deal_repository.dart'; // Import the new Firestore repository

abstract class DealRepository {
  Future<List<Deal>> getDeals();
  Future<void> addDeal(Deal deal);
  Future<void> updateDeal(Deal deal);
  Future<void> deleteDeal(String id);

  // Factory constructor to return the Firestore implementation
  factory DealRepository() {
    return FirestoreDealRepository();
  }
}
