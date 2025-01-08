import 'package:flutter/material.dart';

class RiwayatPengajuanCuti extends StatefulWidget {
  const RiwayatPengajuanCuti({super.key});

  @override
  State<RiwayatPengajuanCuti> createState() => _RiwayatPengajuanCutiState();
}

class _RiwayatPengajuanCutiState extends State<RiwayatPengajuanCuti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[800],
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        // elevation: 5,
        title: const Text(
          "Riwayat Pengajuan Cuti",
          style: TextStyle(
            color: Colors.white, // Ubah warna teks menjadi biru
            fontSize: 20, // Ukuran teks
          ),
        ),
        backgroundColor: Colors.blue[800],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tab Buttons
              // Container(
              //   color: Colors.grey[200],
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //             elevation: 0,
              //             backgroundColor: Colors.grey[200],
              //           ),
              //           onPressed: () {},
              //           child: Text('Form Pengajuan Cuti', style: TextStyle(color: Colors.black)),
              //         ),
              //       ),
              //       Expanded(
              //         child: ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //             elevation: 0,
              //             backgroundColor: Colors.blue[700],
              //           ),
              //           onPressed: () {},
              //           child: Text('Riwayat Pengajuan', style: TextStyle(color: Colors.white)),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
        
              // Informasi Cuti
              Padding(
                
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informasi Cuti',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
        
                    Row(
                      children: [
                        _infoCard('Sisa Cuti', '0', Colors.blue),
                        const SizedBox(width: 8),
                        _infoCard('Superior 1', 'Sigit Susanto\nPimpinan Departement', Colors.grey),
                        const SizedBox(width: 8),
                        _infoCard('Superior 2', 'Said Yovina\nPimpinan Perusahaan', Colors.grey),
                      ],
                    ),
        
                    const SizedBox(height: 16),
        
                    // Detail Informasi
                    _buildDetailField('Jenis Cuti', 'Cuti Tahunan'),
                    _buildDetailField('Tanggal Cuti', '16-10-2024'),
                    _buildDetailField('Sampai Tanggal', '22-10-2024'),
                    _buildDetailField('Jumlah Cuti', '12'),
                    
                    // Status Approval
                    // _buildStatusField('Status Approval', 'Menunggu Approval', Colors.yellow[700]!),
                    _buildStatusField('Status Approval', 'Disetujui', Colors.green[400]!),
                    // _buildStatusField('Status Approval', 'Tidak Disetujui', Colors.red[400]!),
        
                    // Keterangan Cuti
                    _buildDetailField('Keterangan Cuti', 'Pulang Kampung'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String subtitle, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black)),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusField(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}