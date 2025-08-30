import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<T>> documentsStream<T>({
    required String path,
    required T fromMap(Map<String, dynamic> data, String documentId),
  }) {
    return _db.collection(path).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final collection = _db.collection(path);
    await collection.add(data);
  }

  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _db.doc(path);
    await docRef.update(data);
  }

  Future<void> deleteDocument({required String path}) async {
    final docRef = _db.doc(path);
    await docRef.delete();
  }
}
