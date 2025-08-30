import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/deal.dart';
import './deal_repository.dart';

class FirestoreDealRepository implements DealRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Deal>> getDeals() {
    return _firestore.collection('deals').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Deal.fromMap(doc.data(), doc.id)).toList();
    });
  }

  @override
  Future<void> addDeal(Deal deal) {
    return _firestore.collection('deals').add(deal.toMap());
  }

  @override
  Future<void> updateDeal(Deal deal) {
    return _firestore.collection('deals').doc(deal.id).update(deal.toMap());
  }

  @override
  Future<void> deleteDeal(String id) {
    return _firestore.collection('deals').doc(id).delete();
  }
}
