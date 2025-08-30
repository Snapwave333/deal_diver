class Deal {
  final String id;
  final String title;
  final String description;
  final double price;

  Deal({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Deal.fromMap(Map<String, dynamic> data, String documentId) {
    return Deal(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
    };
  }
}
