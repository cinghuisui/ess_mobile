import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ess_mobile/pengajuan_cuti_page.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_ess/model/cuti_page.dart';
// import 'cuti_izin_page.dart'; // Import halaman cuti/izin

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;
  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
  // final List<Widget> _pages = [
  //   Center(child: Text('Home', style: TextStyle(fontSize: 24))),
  //   Center(child: Text('Search', style: TextStyle(fontSize: 24))),
  //   Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Tambahkan logika aksi jika diperlukan
    if (index == 2) {
      // Contoh: Logika untuk keluar aplikasi di halaman "Kunci"
      exit(0);
    }
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });

  //   // Tambahkan logika aksi jika diperlukan
  //   if (index == 3) {
  //     // Contoh: Logika untuk keluar aplikasi di halaman "Kunci"
  //     exit(0);
  //   }
  // }
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DashboardScreen(),
//     );
//   }
// }

// class DashboardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'PT. ASKAR DASKA MANDALA',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
            // style: TextStyle(
            //   color: Colors.white, // Ubah warna teks menjadi biru
            //   fontSize: 20, // Ukuran teks
            //   fontWeight: FontWeight.bold
            // ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[800],

        // leading: new Icon(Icons.home),
      ),
      body: Column(
        children: [
          // _pages[_selectedIndex],
          // Bagian profil header
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 152, 195, 238),
                  Color.fromARGB(255, 4, 130, 240),
                ],
              ),
            ),
            // color: Colors.blue[100],
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                      'assets/images/jancok.png'), // Tambahkan gambar di folder assets
                  // backgroundImage: AssetImage('images/user (3).png'),  // Tambahkan gambar di folder assets
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Andi Sulaiman",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "RMP00023",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Parer",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bagian grid menu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildMenuItem(
                      context,
                      Icons.person,
                      "Cuti / Izin",
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PengajuanCuti()))), // Navigasi ke halaman cuti/izin
                  _buildMenuItem(context, Icons.money, "Slip Gaji", () {
                    // Tambahkan navigasi
                  }),
                  _buildMenuItem(context, Icons.calendar_today, "Absensi", () {
                    // Tambahkan navigasi
                  }),
                  _buildMenuItem(context, Icons.warning, "Pelanggaran", () {
                    // Tambahkan navigasi
                  }),
                  _buildMenuItem(
                      context, Icons.shopping_cart, "Transaksi Belanja", () {
                    // Tambahkan navigasi
                  }),
                  _buildMenuItem(context, Icons.update, "Update Data", () {
                    // Tambahkan navigasi
                  }),
                  _buildMenuItem(context, Icons.lock, "OTP Transaksi", () {
                    // Tambahkan navigasi
                  }),
                  _buildMenuItem(context, Icons.block, "Kosong", () {
                    // Tambahkan navigasi
                  }),
                  _buildMenuItem(context, Icons.settings, "Pengaturan", () {
                    // Tambahkan navigasi
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bagian bottom navigation bar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_add, size: 30),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lock, size: 30),
                label: 'Kunci',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blue,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: Colors.blue[800],
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            elevation: 5,
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat menu
  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.blue[800],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
// }
}
