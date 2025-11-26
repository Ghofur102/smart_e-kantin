import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/products_model.dart';
import '../widgets/custom_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Dummy cart items
  final List<CartItem> cartItems = [
    CartItem(
      product: Product(
        id: '1',
        name: 'Nasi Goreng',
        price: 15000,
        image: 'assets/images/nasi_goreng.png',
        description: 'Nasi goreng dengan telur dan sayuran',
        stock: 20,
      ),
      quantity: 2,
    ),
    CartItem(
      product: Product(
        id: '2',
        name: 'Mie Goreng',
        price: 12000,
        image: 'assets/images/mie_goreng.png',
        description: 'Mie goreng spesial dengan bumbu khas',
        stock: 15,
      ),
      quantity: 1,
    ),
  ];

  double get _totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          AppStrings.cartTitle,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimensions.textLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                AppStrings.emptyCart,
                style: const TextStyle(
                  fontSize: AppDimensions.textMedium,
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : Column(
              children: [
                // Cart List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(cartItems[index], index);
                    },
                  ),
                ),
                // Total & Checkout
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border(top: BorderSide(color: AppColors.divider)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '${AppStrings.totalPrice}:',
                            style: TextStyle(
                              fontSize: AppDimensions.textLarge,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Rp ${_totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: AppDimensions.textLarge,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.marginMedium),
                      PrimaryButton(
                        text: AppStrings.btnCheckout,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Proceeding to checkout...'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: AppDimensions.productImageSize,
            height: AppDimensions.productImageSize,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
            ),
            child: Icon(Icons.restaurant, size: 36, color: AppColors.accent),
          ),
          const SizedBox(width: AppDimensions.marginMedium),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: AppDimensions.textMedium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${item.product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: AppDimensions.textSmall,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                // Quantity Control
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (item.quantity > 1) {
                            item.quantity--;
                          } else {
                            cartItems.removeAt(index);
                          }
                        });
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(
                            fontSize: AppDimensions.textMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          item.quantity++;
                        });
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Total Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rp ${item.totalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: AppDimensions.textMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
