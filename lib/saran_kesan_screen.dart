import 'package:flutter/material.dart';

class SaranKesanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saran Kesan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Perkuliahan Teknologi Pemrograman Mobile dapat ditingkatkan dengan lebih banyak sesi praktikum agar mahasiswa dapat menguasai konsep secara langsung. Proyek akhir yang relevan dengan industri dan pembaruan materi yang terkini juga perlu diperhatikan agar mahasiswa siap terjun ke dunia kerja. Kolaborasi dengan industri dan analisis studi kasus aplikasi nyata bisa memberikan wawasan praktis kepada mahasiswa. Di sisi lain, perkuliahan ini memberikan pengalaman interaktif dan materi yang relevan dengan industri, didukung oleh pengajar yang kompeten dan fasilitas yang memadai. Lingkungan belajar yang kondusif membuat suasana perkuliahan menjadi nyaman dan mendukung kreativitas mahasiswa. Dengan demikian, perkuliahan ini diharapkan dapat lebih mempersiapkan mahasiswa untuk menghadapi tantangan di dunia industri mobile.',
              style: TextStyle(fontSize: 10), 
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showLogoutDialog(context); // Panggil fungsi untuk menampilkan dialog logout
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () {
                // Lakukan logika logout di sini
                // Contoh: membersihkan sesi atau informasi otentikasi, dan lainnya
                // Setelah itu, arahkan pengguna ke halaman masuk atau halaman lain yang sesuai
                Navigator.of(context).pop(); // Tutup dialog
                // Misalnya:
                Navigator.pushReplacementNamed(context, '/login'); // Ganti '/login' dengan rute halaman masuk yang sesuai
              },
            ),
          ],
        );
      },
    );
  }
}
