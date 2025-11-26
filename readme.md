# Smart E-Kantin - Flutter UI Implementation

## Struktur Folder
```
lib/
├── main.dart                 # Entry point dengan routing
├── constants/
│   └── app_constants.dart    # Warna, dimensi, strings
├── screens/
│   ├── login_screen.dart     # Login Screen
│   ├── register_screen.dart  # Register Screen
│   ├── home_screen.dart      # Home Screen dengan grid produk
│   └── cart_screen.dart      # Cart Screen dengan daftar item
├── widgets/
│   └── custom_widgets.dart   # PrimaryButton, CustomTextField, SecondaryButton
├── models/
│   └── product_model.dart    # Product & CartItem models
```

## Screens yang Sudah Dibuat

### 1. Login Screen (`login_screen.dart`)
- Input Email & Password
- Validasi form (email harus valid, password minimal 6 karakter)
- Tombol Login dengan loading state
- Link ke Register
- Navigasi ke Home setelah login

### 2. Register Screen (`register_screen.dart`)
- Input Full Name, Email Kampus, Password, Confirm Password
- Validasi input tidak boleh kosong
- Validasi password cocok
- Tombol Register dengan loading
- Back button ke Login

### 3. Home Screen (`home_screen.dart`)
- Header dengan app name & cart icon
- Grid view produk (2 kolom)
- Setiap produk card menampilkan:
  - Gambar placeholder
  - Nama produk
  - Harga
  - Tombol "Tambah"
- Dummy data: 4 produk (Nasi Goreng, Mie Goreng, Ayam Goreng, Soto Ayam)

### 4. Cart Screen (`cart_screen.dart`)
- List item di keranjang dengan:
  - Gambar produk
  - Nama & harga
  - Quantity control (+ / -)
  - Subtotal per item
- Total harga di bawah
- Tombol Checkout
- Pesan jika keranjang kosong

## Reusable Widgets (`custom_widgets.dart`)

### PrimaryButton
- Tombol biru (warna primary)
- Support loading state dengan spinner
- Border radius consistent

### CustomTextField
- Input dengan label hint
- Support password toggle (mata icon)
- Validasi dari parent
- Focus state dengan border biru

### SecondaryButton
- Text button dengan warna primary
- Untuk navigasi (misal "Belum punya akun? Register")

## Color & Style Constants
Semua warna dan dimensi disimpan di `app_constants.dart`:
- **Primary**: #0D47A1 (biru)
- **Accent**: #FF7043 (oranye)
- **Background**: #FFFFFF (putih)
- **Surface**: #F6F8FB (abu-abu muda)
- Button Height: 48dp
- Input Height: 56dp

## Routing
```dart
Routes yang tersedia:
- /login     → LoginScreen (default/home)
- /register  → RegisterScreen
- /home      → HomeScreen
- /cart      → CartScreen
```

## Cara Menjalankan

### Requirements
- Flutter SDK (versi terbaru)
- Android emulator atau device fisik

### Steps
1. Masuk folder project:
```bash
cd "d:\Mobile Dev\smart_e-kantin"
```

2. Fetch dependencies:
```bash
flutter pub get
```

3. Jalankan app:
```bash
flutter run
```

Atau dengan specific device:
```bash
flutter run -d <device_id>
```

## Testing

### Test Flow
1. Buka app → akan di-direct ke Login Screen
2. Test Login:
   - Coba submit kosong (validasi error)
   - Input email invalid (validasi error)
   - Input email & password valid → bisa login
3. Test Register:
   - Klik link "Belum punya akun? Register"
   - Test validasi form
   - Klik Register → back ke Login dengan snackbar sukses
4. Test Home:
   - Setelah login, masuk ke Home Screen
   - Grid produk tampil
   - Klik "Tambah" → snackbar "ditambahkan ke keranjang"
   - Klik cart icon → ke Cart Screen
5. Test Cart:
   - Lihat dummy cart items
   - Klik +/- untuk ubah quantity
   - Total harga update otomatis
   - Klik Checkout → snackbar "Proceeding to checkout"

## Next Steps (Integrasi dengan Tim Lain)

### Anggota 3 (Logic Auth & Profile)
- Replace dummy login validation dengan API integration
- Simpan token & user data ke local storage
- Implementasi session management

### Anggota 4 (Logic Transaksi)
- Integrate cart logic dengan Provider/Bloc state management
- Implementasi diskon ganjil/genap berdasarkan NIM
- Connect checkout ke payment gateway

### Anggota 5 (QA & Testing)
- Test semua skenario user flow
- Check responsive di berbagai ukuran screen
- Integration testing dengan backend API

## File yang Sudah di-Generate
- ✅ main.dart
- ✅ lib/constants/app_constants.dart
- ✅ lib/screens/login_screen.dart
- ✅ lib/screens/register_screen.dart
- ✅ lib/screens/home_screen.dart
- ✅ lib/screens/cart_screen.dart
- ✅ lib/widgets/custom_widgets.dart
- ✅ lib/models/product_model.dart

## ID Komponen (suffix _hud)
Semua komponen UI sudah mengikuti penamaan dengan suffix `_hud` (untuk digunakan nanti di Kotlin/testing):
- `ivLogo_hud`, `etEmail_hud`, `btnLogin_hud`, dll

---
**Status**: ✅ UI Layer selesai dikerjakan
**Last Updated**: November 26, 2025
