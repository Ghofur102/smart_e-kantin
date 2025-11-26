import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';
import '../models/cart_item_model.dart';
import '../utils/discount_calculator.dart';

class CartRepository {
  static const String _cartKey = 'cart_data';
  late SharedPreferences _prefs;

  /// Initialize repository dengan SharedPreferences
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Ambil cart dari local storage
  Future<CartModel> getCart(String userId) async {
    try {
      final cartJson = _prefs.getString(_cartKey);
      if (cartJson == null) {
        return CartModel.empty();
      }

      final cartData = jsonDecode(cartJson) as Map<String, dynamic>;
      return CartModel.fromMap(cartData);
    } catch (e) {
      print('Error getting cart: $e');
      return CartModel.empty();
    }
  }

  /// Simpan cart ke local storage
  Future<void> saveCart(CartModel cart) async {
    try {
      final cartJson = jsonEncode(cart.toMap());
      await _prefs.setString(_cartKey, cartJson);
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  /// Tambah item ke cart
  /// Jika item sudah ada, update quantity-nya
  Future<CartModel> addToCart(
    CartModel currentCart,
    CartItemModel newItem,
    String userId,
  ) async {
    final items = List<CartItemModel>.from(currentCart.items);

    // Cek apakah item sudah ada di cart
    final existingItemIndex =
        items.indexWhere((item) => item.productId == newItem.productId);

    if (existingItemIndex != -1) {
      // Item sudah ada, update quantity
      final existingItem = items[existingItemIndex];
      items[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + newItem.quantity,
      );
    } else {
      // Item baru, tambahkan
      items.add(newItem);
    }

    // Hitung ulang total
    return _recalculateCart(items, userId);
  }

  /// Remove item dari cart
  Future<CartModel> removeFromCart(
    CartModel currentCart,
    String productId,
    String userId,
  ) async {
    final items = currentCart.items
        .where((item) => item.productId != productId)
        .toList();

    return _recalculateCart(items, userId);
  }

  /// Update quantity item di cart
  Future<CartModel> updateItemQuantity(
    CartModel currentCart,
    String productId,
    int newQuantity,
    String userId,
  ) async {
    if (newQuantity <= 0) {
      return removeFromCart(currentCart, productId, userId);
    }

    final items = currentCart.items.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    return _recalculateCart(items, userId);
  }

  /// Clear cart
  Future<CartModel> clearCart() async {
    await _prefs.remove(_cartKey);
    return CartModel.empty();
  }

  /// Helper: Hitung ulang cart dengan diskon
  CartModel _recalculateCart(List<CartItemModel> items, String userId) {
    final subtotal = CartModel.calculateSubtotal(items);
    final discountAmount = DiscountCalculator.calculateDiscountAmount(subtotal, userId);
    final total = subtotal - discountAmount;

    return CartModel(
      items: items,
      subtotal: subtotal,
      discountAmount: discountAmount,
      total: total,
    );
  }

  /// Get discount info untuk cart
  Map<String, dynamic> getDiscountInfo(CartModel cart, String userId) {
    return DiscountCalculator.getDiscountInfo(cart.subtotal, userId);
  }

  /// Check apakah cart kosong
  bool isCartEmpty(CartModel cart) {
    return cart.items.isEmpty;
  }
}
