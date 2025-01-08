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
      home: PengajuanCutiScreen(),
    );
  }
}

class PengajuanCutiScreen extends StatelessWidget {
  PengajuanCutiScreen({super.key});

  final Map<String, String> cutiData = {
    "Nama": "Susanto",
    "NIK ID Card": "344454",
    "Jabatan": "Operator",
    "Hari Libur/IM": "Senin",
    "Cuti Pada Tanggal":
        "21-10-2024 s/d 22-10-2024 (2 Hari) (Cuti Tahunan/Cuti Melahirkan)",
    "Sisa Cuti": "10",
    "Izin Pada Tanggal": "  /  / (Hari)",
    "Dengan Alasan": "Cuti Kompensasi | Khitan Anak",
    "Pemohon": "Susanto",
    "Disetujui": "Said Yovinza",
    "Diketahui": "Sigit Susanto",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text(
          "Surat Permohonan Izin/Cuti",
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
        decoration: const BoxDecoration(
          color: Colors.white,
          //  image: DecorationImage(
          //   image: AssetImage("assets/images/coconutoil.webp"), // Gambar dari folder assets
          //   fit: BoxFit.cover, // Menyesuaikan gambar agar memenuhi layar
          // ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              const Text(
                "PT. MANDALA UTAMA",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                "Alamat: Jl. BTN Parit Satu, Dusun Sinar Baru, Desa Pulau Burung, Kec. Pulau Burung, Kab. Indragiri Hilir, Prov. Riau - Kode Pos 29256\nTelp: 0812345671234 - Email: ptmandalautama@gmail.com",
                style: TextStyle(fontSize: 7,
                fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height: 4), // Memberikan jarak antara teks dan garis
              Container(
                width: 330, // Panjang garis
                height: 2, // Ketebalan garis
                color: Colors.black, // Warna garis
              ),
              const SizedBox(height: 16),
              // Title Surat
              const Text(
                "SURAT PERMOHONAN IZIN/CUTI",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Body Surat
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Saya yang bertanda tangan di bawah ini:",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              _buildRow("Nama", cutiData["Nama"]!),
              _buildRow("NIK ID Card", cutiData["NIK ID Card"]!),
              _buildRow("Jabatan", cutiData["Jabatan"]!),
              _buildRow("Hari Libur/IM", cutiData["Hari Libur/IM"]!),
              _buildRow("Cuti Pada Tanggal", cutiData["Cuti Pada Tanggal"]!),
              _buildRow("Sisa Cuti", cutiData["Sisa Cuti"]!),
              _buildRow("Izin Pada Tanggal", cutiData["Izin Pada Tanggal"]!),
              _buildRow("Dengan Alasan", cutiData["Dengan Alasan"]!),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dengan ini mengajukan permohonan Izin/Cuti. Atas perhatianya saya ucapkan terima kasih.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 32),
              // Signature Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSignature("Pemohon", cutiData["Pemohon"]!),
                  _buildSignature("Disetujui", cutiData["Disetujui"]!),
                  _buildSignature("Diketahui", cutiData["Diketahui"]!),
                ],
              ),
              const SizedBox(height: 25),
              // Catatan
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Catatan:\n- Kembali masuk kerja pada tanggal ...\nLampiran:\n- Photo copy Buku Nikah/KK - MENIKAH(3.Hk)\n- Photo copy Buku Nikah/KK - ANAK KANDUNG MENIKAH(2.Hk)\n- Surat Kematian/KK(Orang tua/Mertua/Istri/Suami/Menantu/Anak)(2.Hk)\n- Surat Kelahiran Anak/Photo Copy Buku Nikah - ISTRI MELAHIRKAN(2.Hk)",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tembusan:\n- Departemen Terkait\n- HRD -PT.RSUP",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$title :",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildSignature(String title, String name) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 48), // Ruang untuk tanda tangan
        Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
