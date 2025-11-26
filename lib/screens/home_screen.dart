import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/products_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy product data
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Nasi Goreng',
      price: 15000,
      image: 'assets/images/nasi_goreng.png',
      description: 'Nasi goreng dengan telur dan sayuran',
      stock: 20,
    ),
    Product(
      id: '2',
      name: 'Mie Goreng',
      price: 12000,
      image: 'assets/images/mie_goreng.png',
      description: 'Mie goreng spesial dengan bumbu khas',
      stock: 15,
    ),
    Product(
      id: '3',
      name: 'Ayam Goreng',
      price: 18000,
      image: 'assets/images/ayam_goreng.png',
      description: 'Ayam goreng renyah dengan nasi putih',
      stock: 25,
    ),
    Product(
      id: '4',
      name: 'Soto Ayam',
      price: 14000,
      image: 'assets/images/soto_ayam.png',
      description: 'Soto ayam hangat dengan kuah kuning',
      stock: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          AppStrings.homeTitle,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimensions.textLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/cart'),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.cornerRadius,
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: AppDimensions.marginMedium,
          mainAxisSpacing: AppDimensions.marginMedium,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.cornerRadius),
                  topRight: Radius.circular(AppDimensions.cornerRadius),
                ),
              ),
              child: Icon(Icons.restaurant, size: 48, color: AppColors.accent),
            ),
          ),
          // Product Info
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: AppDimensions.textMedium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: AppDimensions.textSmall,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product.name} ditambahkan ke keranjang',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Tambah',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppDimensions.textSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
