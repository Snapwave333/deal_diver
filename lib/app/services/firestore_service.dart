import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    final reference = _db.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map((doc) => builder(doc.data(), doc.id))
        .toList());
  }

  Future<void> addDocument({
    required String path,
    required Map<String, dynamic> data,
  }) {
    final reference = _db.collection(path);
    return reference.add(data);
  }
}
