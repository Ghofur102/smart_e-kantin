/// Utility class untuk menghitung diskon berdasarkan userId (NIM)
/// Aturan: 
/// - NIM/userId dengan angka terakhir GANJIL (1,3,5,7,9) = Diskon 10%
/// - NIM/userId dengan angka terakhir GENAP (0,2,4,6,8) = Diskon 5%
class DiscountCalculator {
  /// Ambil digit terakhir dari userId (NIM)
  static int _getLastDigit(String userId) {
    if (userId.isEmpty) return 0;
    final lastChar = userId[userId.length - 1];
    return int.tryParse(lastChar) ?? 0;
  }

  /// Cek apakah NIM ganjil
  static bool _isOddNim(String userId) {
    final lastDigit = _getLastDigit(userId);
    return lastDigit % 2 != 0;
  }

  /// Dapatkan persentase diskon berdasarkan userId
  /// Returns persentase diskon (10 atau 5)
  static int getDiscountPercentage(String userId) {
    return _isOddNim(userId) ? 10 : 5;
  }

  /// Hitung amount diskon dari subtotal
  /// [subtotal] = total sebelum diskon
  /// [userId] = userId/NIM untuk menentukan persentase diskon
  static int calculateDiscountAmount(int subtotal, String userId) {
    final discountPercentage = getDiscountPercentage(userId);
    return (subtotal * discountPercentage) ~/ 100; // ~/ adalah integer division
  }

  /// Hitung total akhir setelah diskon
  /// [subtotal] = total sebelum diskon
  /// [userId] = userId/NIM untuk menentukan persentase diskon
  static int calculateFinalTotal(int subtotal, String userId) {
    final discountAmount = calculateDiscountAmount(subtotal, userId);
    return subtotal - discountAmount;
  }

  /// Get discount info untuk display
  static Map<String, dynamic> getDiscountInfo(int subtotal, String userId) {
    final discountPercentage = getDiscountPercentage(userId);
    final discountAmount = calculateDiscountAmount(subtotal, userId);
    final finalTotal = calculateFinalTotal(subtotal, userId);

    return {
      'discountPercentage': discountPercentage,
      'discountAmount': discountAmount,
      'finalTotal': finalTotal,
      'isOdd': _isOddNim(userId),
    };
  }
}
