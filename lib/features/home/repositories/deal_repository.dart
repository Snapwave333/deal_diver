import 'package:myapp/app/services/firestore_service.dart';
import 'package:myapp/features/home/models/deal_model.dart';

abstract class DealRepository {
  Stream<List<Deal>> getDeals();
  Future<void> addDeal(Deal deal);
}

class FirestoreDealRepository implements DealRepository {
  final _firestoreService = FirestoreService();

  @override
  Stream<List<Deal>> getDeals() {
    return _firestoreService.collectionStream(
      path: 'deals',
      builder: (data, documentId) => Deal.fromMap(data, documentId),
    );
  }

  @override
  Future<void> addDeal(Deal deal) {
    return _firestoreService.addDocument(
      path: 'deals',
      data: deal.toMap(),
    );
  }
}
