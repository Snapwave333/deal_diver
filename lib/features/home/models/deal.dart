class Deal {
  final String? id; // Can be null for new deals
  String title;
  String description;
  double price;
  final String image;

  Deal({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  // From Firestore document to Deal object
  factory Deal.fromMap(Map<String, dynamic> data, String documentId) {
    return Deal(
      id: documentId,
      title: data['title'],
      description: data['description'],
      price: (data['price'] as num).toDouble(),
      image: data['image'],
    );
  }

  // From Deal object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
