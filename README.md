# ⚽ Futsal Arena - Booking App

## Deskripsi Aplikasi

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

# Tampilan Aplikasi

1. Tampilan Awal
<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (1)" src="https://github.com/user-attachments/assets/c60f32c6-7c90-4f2a-a6f9-24a58798d1c9" />
</p>

2. Menu Registrasi
<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (2)" src="https://github.com/user-attachments/assets/542c9fda-8f41-49cb-97a8-7f5b69944ffa" />
</p>

3. Tampilan Homepage
<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE)" src="https://github.com/user-attachments/assets/ba1268f4-bbd2-440d-b117-d064bb2f86de" />
</p>

4. Tampilan Saat menambah Booking
<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (3)" src="https://github.com/user-attachments/assets/ad4d807d-9c10-4e24-8483-135330b65ab9" />
</p>
5. Tampilan saat mengupdate data boooking
<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (4)" src="https://github.com/user-attachments/assets/57237ce7-9f90-4b45-bb0b-a22030022e2b" />
</p>

6. Tampilan saat akan menghapus data
<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (5)" src="https://github.com/user-attachments/assets/759fc9c8-4c31-4409-a675-b3a0632bff6d" />  
</p>

7. Tampilan saat menggunakan tema dark
<p align="center">
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (6)" src="https://github.com/user-attachments/assets/0712e8d8-f7a0-4ab3-8c02-1b674c24213b" />
</p>

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (11)" src="https://github.com/user-attachments/assets/b219e2b5-09c0-4cf1-a981-8cb81ee31d9d" />
<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (8)" src="https://github.com/user-attachments/assets/a53aeb75-53e6-41c2-b54f-3f2c3d8b2870" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (7)" src="https://github.com/user-attachments/assets/d2b3e1b2-f46e-4d6d-ad2c-46dcb30d52e2" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (6)" src="https://github.com/user-attachments/assets/0712e8d8-f7a0-4ab3-8c02-1b674c24213b" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (5)" src="https://github.com/user-attachments/assets/759fc9c8-4c31-4409-a675-b3a0632bff6d" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (4)" src="https://github.com/user-attachments/assets/57237ce7-9f90-4b45-bb0b-a22030022e2b" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (3)" src="https://github.com/user-attachments/assets/ad4d807d-9c10-4e24-8483-135330b65ab9" />



<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (10)" src="https://github.com/user-attachments/assets/13e69d3d-abe5-4836-9681-12f300355a68" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (2)" src="https://github.com/user-attachments/assets/542c9fda-8f41-49cb-97a8-7f5b69944ffa" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (1)" src="https://github.com/user-attachments/assets/c60f32c6-7c90-4f2a-a6f9-24a58798d1c9" />

<img width="300" height="1333" alt="localhost_50602_(iPhone SE)" src="https://github.com/user-attachments/assets/ba1268f4-bbd2-440d-b117-d064bb2f86de" />




<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (9)" src="https://github.com/user-attachments/assets/546f5315-308f-488a-852d-920d144ecb64" />



<img width="300" height="1333" alt="localhost_50602_(iPhone SE) (11)" src="https://github.com/user-attachments/assets/dc444e1d-bb9c-410b-bfb2-b3c863878142" />
</p>

