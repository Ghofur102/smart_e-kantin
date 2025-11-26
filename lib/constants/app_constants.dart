import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D47A1);
  static const Color primaryDark = Color(0xFF08306B);
  static const Color accent = Color(0xFFFF7043);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF6F8FB);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
}

class AppDimensions {
  static const double paddingXs = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double marginXs = 4.0;
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;

  static const double textXs = 10.0;
  static const double textSmall = 12.0;
  static const double textMedium = 16.0;
  static const double textLarge = 20.0;
  static const double textXl = 24.0;

  static const double logoSize = 96.0;
  static const double productImageSize = 72.0;
  static const double cornerRadius = 12.0;
  static const double buttonHeight = 48.0;
  static const double inputHeight = 56.0;
}

class AppStrings {
  // App
  static const String appName = 'Smart E-Kantin';

  // Login
  static const String loginTitle = 'Login';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';
  static const String btnLogin = 'Login';
  static const String registerLink = 'Belum punya akun? Register';

  // Register
  static const String registerTitle = 'Register';
  static const String fullNameHint = 'Nama Lengkap';
  static const String emailKampusHint = 'Email Kampus';
  static const String confirmPasswordHint = 'Konfirmasi Password';
  static const String btnRegister = 'Register';

  // Home
  static const String homeTitle = 'Smart E-Kantin';
  static const String productsList = 'Daftar Produk';

  // Cart
  static const String cartTitle = 'Keranjang';
  static const String totalPrice = 'Total: Rp ';
  static const String btnCheckout = 'Checkout';
  static const String emptyCart = 'Keranjang kosong';

  // Product
  static const String productName = 'Nama Produk';
  static const String productPrice = 'Rp ';
}
