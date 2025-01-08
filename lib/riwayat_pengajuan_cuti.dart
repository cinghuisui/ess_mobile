import 'package:ess_mobile/surat_cuti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CutiRiwayatPage(),
    );
  }
}

class CutiRiwayatPage extends StatelessWidget {
  const CutiRiwayatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text(
          "Riwayat Pengajuan Cuti",
          style: TextStyle(
            color: Colors.white, // Ubah warna teks menjadi biru
            fontSize: 20, // Ukuran teks
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            // Icons.arrow_back,
            Icons.chevron_left_rounded,size: 35,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity, // Mengisi lebar layar
        height: double.infinity, // Mengisi tinggi layar
        decoration: const BoxDecoration(
          
            // color: Color.fromARGB(255, 222, 203, 206),
            image: DecorationImage(
            image: AssetImage("assets/images/coconut.webp"), // Gambar dari folder assets
            fit: BoxFit.cover, // Menyesuaikan gambar agar memenuhi layar
          ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  cutiCard(
                    jenisCuti: "Cuti Tahunan",
                    tanggalCuti: "16-10-2024",
                    sampaiTanggal: "22-10-2024",
                    jumlahCuti: "12",
                    statusApproval: "Disetujui",
                    statusColor: Colors.green,
                    keterangan: "Traveling",
                  ),
                  cutiCard(
                    jenisCuti: "Cuti Melahirkan",
                    tanggalCuti: "16-10-2024",
                    sampaiTanggal: "22-10-2024",
                    jumlahCuti: "12",
                    statusApproval: "Menunggu Approve",
                    statusColor: Colors.orange,
                    keterangan: "Traveling",
                  ),
                  cutiCard(
                    jenisCuti: "Cuti Gajah",
                    tanggalCuti: "16-10-2024",
                    sampaiTanggal: "22-10-2024",
                    jumlahCuti: "12",
                    statusApproval: "Tidak Disetujui",
                    statusColor: Colors.red,
                    keterangan: "Traveling",
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PengajuanCutiScreen()),
                      );
                  // Aksi ketika tombol "Lihat Form" ditekan
                },
                child: const Text(
                  "Lihat Form",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cutiCard({
    required String jenisCuti,
    required String tanggalCuti,
    required String sampaiTanggal,
    required String jumlahCuti,
    required String statusApproval,
    required Color statusColor,
    required String keterangan,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowText("Jenis Cuti", jenisCuti),
          rowText("Tanggal Cuti", tanggalCuti),
          rowText("Sampai Tanggal", sampaiTanggal),
          rowText("Jumlah Cuti", jumlahCuti),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Status Approval",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                statusApproval,
                style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
              ),
            ],
          ),
          rowText("Keterangan Cuti", keterangan),
        ],
      ),
    );
  }

  Widget rowText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title :",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
