class CartItemModel {
  final String productId;
  final String productName;
  final int price;
  int quantity;
  final String imageUrl;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  /// Hitung subtotal untuk item ini (price * quantity)
  int get subtotal => price * quantity;

  /// Konversi ke map untuk disimpan ke local storage
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  /// Konversi dari map ke CartItemModel
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      price: map['price'] ?? 0,
      quantity: map['quantity'] ?? 1,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  /// Create copy untuk immutability pattern
  CartItemModel copyWith({
    String? productId,
    String? productName,
    int? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
