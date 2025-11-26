import 'cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;
  final int subtotal;
  final int discountAmount;
  final int total;

  CartModel({
    required this.items,
    required this.subtotal,
    required this.discountAmount,
    required this.total,
  });

  /// Hitung total item di keranjang
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// Hitung subtotal dari semua items
  static int calculateSubtotal(List<CartItemModel> items) {
    return items.fold(0, (sum, item) => sum + item.subtotal);
  }

  /// Factory untuk membuat cart kosong
  factory CartModel.empty() {
    return CartModel(
      items: [],
      subtotal: 0,
      discountAmount: 0,
      total: 0,
    );
  }

  /// Konversi ke map untuk disimpan ke local storage
  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'total': total,
    };
  }

  /// Konversi dari map ke CartModel
  factory CartModel.fromMap(Map<String, dynamic> map) {
    final itemsList = (map['items'] as List<dynamic>?)
        ?.map((item) => CartItemModel.fromMap(item as Map<String, dynamic>))
        .toList() ??
        [];

    return CartModel(
      items: itemsList,
      subtotal: map['subtotal'] ?? 0,
      discountAmount: map['discountAmount'] ?? 0,
      total: map['total'] ?? 0,
    );
  }

  /// Create copy untuk immutability pattern
  CartModel copyWith({
    List<CartItemModel>? items,
    int? subtotal,
    int? discountAmount,
    int? total,
  }) {
    return CartModel(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discountAmount: discountAmount ?? this.discountAmount,
      total: total ?? this.total,
    );
  }
}
