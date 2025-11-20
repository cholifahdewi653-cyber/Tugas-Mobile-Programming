# Waktu Sholat Cerdas

Aplikasi Flutter untuk menampilkan jadwal sholat dan arah Qibla dengan antarmuka yang user-friendly.

## Fitur Utama

### 1. **Home Screen - Jadwal Sholat**
- Menampilkan jadwal sholat harian untuk lokasi pengguna
- Informasi lokasi pengguna (kota dan koordinat)
- Tampilan time-based untuk setiap waktu sholat
- Update otomatis berdasarkan lokasi

### 2. **Calendar Screen - Kalender Sholat**
- Kalender interaktif dengan pilihan tanggal
- Menampilkan jadwal sholat untuk tanggal yang dipilih
- Fitur navigasi bulan sebelumnya/berikutnya
- Highlight untuk hari ini dan tanggal terpilih
- Tampilan ikon cuaca untuk setiap waktu sholat

### 3. **Compass Screen - Kompas Qibla**
- Kompas interaktif yang menunjukkan arah Qibla
- Animasi smooth untuk perubahan heading
- Tampilan derajat dan arah mata angin
- Informasi lokasi pengguna
- Identifikasi arah Qibla relative terhadap lokasi

### 4. **Settings Screen - Pengaturan**
- **Notifikasi**: Aktifkan/nonaktifkan notifikasi waktu sholat
- **Suara & Getaran**: Pengaturan audio feedback
- **Format Waktu**: Pilih antara format 12 jam atau 24 jam
- **Lokasi**: Pilih kota untuk perhitungan waktu sholat
- **Bantuan**: Akses ke kebijakan privasi dan bantuan
- **Logout**: Keluar dari aplikasi

### 5. **Login Screen**
- Form login dengan validasi
- Gradient background design
- Navigasi ke Home setelah login berhasil

## Struktur Folder

```
lib/
├── main.dart              # Entry point aplikasi
├── pages/
│   ├── home_screen.dart      # Layar jadwal sholat
│   ├── calendar_screen.dart  # Layar kalender
│   ├── compass_screen.dart   # Layar kompas Qibla
│   ├── settings_screen.dart  # Layar pengaturan
│   └── login_screen.dart     # Layar login
```

## Dependencies

- **flutter**: UI framework
- **adhan**: Library untuk perhitungan waktu sholat
- **http**: HTTP client untuk API requests
- **geolocator**: Akses lokasi pengguna
- **font_awesome_flutter**: Icon pack tambahan

## Instalasi & Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd waktu_sholat_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Jalankan Aplikasi
```bash
flutter run
```

## Design

### Warna Utama
- **Primary**: Green (#4CAF50)
- **Background**: Green Dark (#388E3C)
- **Accent**: White (#FFFFFF)
- **Alert**: Red (#F44336)

### Typography
- **Header**: Bold, 24px
- **Title**: Bold, 18px
- **Subtitle**: Regular, 14px
- **Body**: Regular, 14px

## Fitur Teknis

### State Management
- Menggunakan `StatefulWidget` untuk screen-screen yang membutuhkan state management
- `setState()` untuk update UI lokal

### Navigation
- Named routes untuk navigasi antar layar
- Navigation dari login ke home
- Navigation dari settings untuk logout

### Animasi
- Animasi smooth pada Compass Screen
- Transition antar screen

## Requirements

- Flutter 3.10.0 atau lebih tinggi
- Dart 3.10.0 atau lebih tinggi
- Android SDK 21 atau lebih tinggi
- iOS 11.0 atau lebih tinggi

## Build APK

### Development Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
```

## Troubleshooting

### Error: "Target of URI doesn't exist"
- Jalankan `flutter pub get` untuk menginstall dependencies

### Error: "No devices"
- Pastikan emulator sudah running atau device terhubung dengan `flutter devices`

## Kontribusi

Untuk berkontribusi, silakan buat pull request dengan deskripsi yang jelas.

## Lisensi

MIT License - Bebas digunakan untuk tujuan komersial dan personal.

## Kontak

Untuk pertanyaan dan dukungan, silakan hubungi tim development.

---

**Versi**: 1.0.0  
**Last Updated**: November 17, 2024

