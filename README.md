# futsal_booking

A new Flutter project.

# ⚽ Futsal Arena - Aplikasi Booking Lapangan Futsal

<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (12)" src="https://github.com/user-attachments/assets/7be9670a-b995-40d6-8fbd-2042bf2ba504" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (11)" src="https://github.com/user-attachments/assets/dc444e1d-bb9c-410b-bfb2-b3c863878142" />
</p>

Aplikasi **Futsal Arena** adalah aplikasi mobile berbasis Flutter untuk melakukan booking lapangan futsal secara online. Aplikasi ini memudahkan pengguna dalam memesan lapangan, melihat daftar booking, serta mengelola data pemesanan dengan integrasi Supabase sebagai backend.

---

## ✨ Fitur Aplikasi

### 🔐 **Autentikasi Pengguna**
- **Login** - Pengguna dapat masuk ke akun yang sudah terdaftar
- **Register** - Pengguna baru dapat membuat akun
- **Logout** - Keluar dari sesi aplikasi
- **Validasi Form** - Validasi input email dan password
- **Error Handling** - Pesan error yang ramah pengguna

### 📅 **Manajemen Booking**
- **Tambah Booking** - Membuat pemesanan lapangan baru
- **Lihat Booking** - Menampilkan daftar booking yang sudah dibuat
- **Edit Booking** - Mengubah data booking yang sudah ada
- **Hapus Booking** - Menghapus data booking dengan konfirmasi

### 📋 **Form Pemesanan**
- **Input Nama** - Nama pemesan (hanya huruf)
- **Input Nomor HP** - Format nomor HP dengan auto-formatting
- **Pilih Lapangan** - Dropdown pilihan lapangan (1-4)
- **Input Jam** - Format jam booking (contoh: 13.20-15.00)

### 🎨 **Tampilan & Tema**
- **Light Mode** - Tema terang untuk siang hari
- **Dark Mode** - Tema gelap untuk kenyamanan malam hari
- **Responsif** - Tampilan menyesuaikan berbagai ukuran layar
- **Gradient Header** - Desain header dengan gradien warna
- **Card Modern** - Tampilan card dengan bayangan halus

### 📊 **Dashboard (Coming Soon)**
- Statistik booking
- Grafik pemesanan
- Ringkasan data

---

## 🧩 Widget yang Digunakan

### **Widget Dasar**
| Widget | Fungsi |
|--------|--------|
| `Scaffold` | Struktur dasar halaman |
| `AppBar` | Bar aplikasi dengan judul dan aksi |
| `Container` | Membungkus dan mendekorasi elemen |
| `Column` | Menyusun widget secara vertikal |
| `Row` | Menyusun widget secara horizontal |
| `Stack` | Menumpuk widget (untuk background pattern) |
| `Padding` | Memberi jarak di dalam widget |
| `SizedBox` | Memberi jarak antar widget |
| `Expanded` | Mengembangkan widget dalam flex layout |

### **Input & Form**
| Widget | Fungsi |
|--------|--------|
| `Form` | Membungkus form dengan validasi |
| `TextFormField` | Input teks dengan validasi |
| `DropdownButtonFormField` | Dropdown pilihan lapangan |
| `ElevatedButton` | Tombol aksi utama |
| `TextButton` | Tombol sekunder |
| `IconButton` | Tombol dengan ikon |

### **Navigasi**
| Widget | Fungsi |
|--------|--------|
| `Navigator` | Mengelola rute halaman |
| `MaterialPageRoute` | Transisi antar halaman |
| `PopupMenuButton` | Menu popup untuk edit/hapus |

### **Dialog & Feedback**
| Widget | Fungsi |
|--------|--------|
| `AlertDialog` | Konfirmasi hapus booking |
| `SnackBar` | Notifikasi error/sukses |
| `CircularProgressIndicator` | Indikator loading |

### **Layout & Styling**
| Widget | Fungsi |
|--------|--------|
| `ListView.builder` | Menampilkan daftar booking |
| `Card` | Membungkus item booking |
| `ListTile` | Item dalam daftar |
| `Gradient` | Gradien warna pada header |
| `BoxDecoration` | Dekorasi container |
| `BoxShadow` | Bayangan pada card |

### **Tema & Responsif**
| Widget | Fungsi |
|--------|--------|
| `ThemeData` | Mengatur tema aplikasi |
| `MediaQuery` | Mendapatkan ukuran layar |
| `Brightness` | Menentukan mode terang/gelap |

### **Formatters & Validasi**
| Widget/Fungsi | Fungsi |
|---------------|--------|
| `TextInputFormatter` | Memformat input |
| `RegExp` | Validasi dengan regex |
| `PhoneNumberFormatter` | Format nomor HP custom |
| `FilteringTextInputFormatter` | Filter karakter input |

---
