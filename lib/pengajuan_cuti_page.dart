// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PengajuanCuti(),
    );
  }
}

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PengajuanCutiState createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _keterangancutiController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final void Function() startQuiz;

  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _masukKerjaDate;
  DateTime? returnDate;
  int _jumlahHariCuti = 0;
  String? _selectedHariLibur;
  String? selectedDepartement;
  String? selectedJabatan;
  String? selectedJenisCuti;
  String? _errorNamaLengkap;
  String? _errorNik;
  String? _errorKeteranganCuti;

  void _clearFields() {
    // Menghapus teks di semua TextEditingController
    _namaLengkapController.clear();
    _nikController.clear();
    _keterangancutiController.clear();
    _hariLiburOptions.clear();
    departement.clear();
    jabatan.clear();
    jenisCutiList.clear();
    _jumlahHariCuti = 0;
    // Mengatur ulang errorText menjadi null
    setState(() {
      _errorNamaLengkap = null;
      // _errorNik = null;
      _errorKeteranganCuti = null;
      _selectedHariLibur = null;
      _startDate = null;
      _endDate = null;
      _masukKerjaDate = null;
      // _errorDept = null;
    });
  }

  final _dateFormat = DateFormat('dd-MM-yyyy');
  final List<String> _hariLiburOptions = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
    // 'Hari Libur Nasional',
  ];
  final List<String> departement = [
    "MPD",
    "Turbin",
    "Quality",
    "PSN",
    "ITD",
    "Security"
  ];
  final List<String> jabatan = [
    "Operator",
    "Supervisor",
    "Manager",
    "Kepalas Sift",
    "ADM"
  ];
  final List<String> jenisCutiList = [
    "Cuti Tahunan",
    "Cuti Sakit",
    "Cuti Melahirkan"
  ];
  // Daftar hari libur nasional (contoh)
  final List<DateTime> _hariLiburNasional = [
    DateTime(2024, 1, 1), // Tahun Baru
    DateTime(2024, 5, 1), // Hari Buruh
    DateTime(2024, 8, 17), // Hari Kemerdekaan
    DateTime(2024, 12, 25), //Hari Natal
  ];

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            content: Text(
              'Pengajuan Cuti berhasil diajukan!',
            )),
      );
      _clearFields();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          content: Text('Mohon di isi semua data dengan benar!'),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Warna utama
              onPrimary: Colors.white, // Warna teks di atas warna utama
              onSurface: Colors.black, // Warna teks lainnya
            ),
          ),
          child: child!,
        );
      },
      selectableDayPredicate: (DateTime date) {
        // Nonaktifkan hari libur nasional pada kalender
        return !_hariLiburNasional.contains(date);
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
          _calculateMasukKerjaDate();
        }
        _calculateDays();
      });
    }
  }

  void _calculateDays() {
    if (_startDate != null && _endDate != null) {
      int totalDays = _endDate!.difference(_startDate!).inDays + 1;
      int liburCount = 0;

      for (int i = 0; i < totalDays; i++) {
        DateTime currentDate = _startDate!.add(Duration(days: i));
        if (_isLibur(currentDate)) {
          liburCount++;
        }
      }

      setState(() {
        _jumlahHariCuti = totalDays - liburCount;
        if (_jumlahHariCuti < 0) _jumlahHariCuti = 0;
      });
    }
  }

  void _calculateMasukKerjaDate() {
    if (_endDate != null) {
      DateTime tempDate = _endDate!.add(const Duration(days: 1));
      while (_isLibur(tempDate)) {
        tempDate = tempDate.add(const Duration(days: 1));
      }
      setState(() {
        _masukKerjaDate = tempDate;
      });
    }
  }

  bool _isLibur(DateTime date) {
    if (_selectedHariLibur == 'Senin' && date.weekday == DateTime.monday) {
      return true;
    } else if (_selectedHariLibur == 'Selasa' &&
        date.weekday == DateTime.tuesday) {
      return true;
    } else if (_selectedHariLibur == 'Rabu' &&
        date.weekday == DateTime.wednesday) {
      return true;
    } else if (_selectedHariLibur == 'Kamis' &&
        date.weekday == DateTime.thursday) {
      return true;
    } else if (_selectedHariLibur == 'Jumat' &&
        date.weekday == DateTime.friday) {
      return true;
    } else if (_selectedHariLibur == 'Sabtu' &&
        date.weekday == DateTime.saturday) {
      return true;
    } else if (_selectedHariLibur == 'Minggu' &&
        date.weekday == DateTime.sunday) {
      return true;
    } else if (_selectedHariLibur == 't') {
      return _hariLiburNasional.contains(date);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Pengajuan Cuti",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nama Lengkap",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _namaLengkapController,
                decoration: InputDecoration(
                  hintText: "Nama Lengkap",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  errorText: _errorNamaLengkap,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK/ID Card harus diisi';
                  }
                  return null;
                },
                inputFormatters: [
                  UpperCaseTextFormatter(), // Formatter untuk huruf besar
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "NIK / ID Card",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nikController,
                decoration: InputDecoration(
                  hintText: "NIK/ID Card",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorText: _errorNik,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK/ID Card harus diisi';
                  }
                  return null;
                },
                inputFormatters: [
                  UpperCaseTextFormatter(), // Formatter untuk huruf besar
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                "Departemen/Bagian",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                hint: const Text("-Pilih Departement-"),
                value: selectedDepartement,
                items: departement.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Departement harus diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              const Text(
                "Jabatan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                hint: const Text("-Pilih Jabatan-"),
                value: selectedJabatan,
                items: jabatan.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedJabatan = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jabatan harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Dropdown Hari Libur
              const Text('Hari Libur/IM',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: '-Pilih Hari-',
                  border: OutlineInputBorder(),
                ),
                value: _selectedHariLibur,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedHariLibur = newValue;
                    _calculateDays();
                    _calculateMasukKerjaDate();
                  });
                },
                items: _hariLiburOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hari Libur harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Jenis Cuti",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                hint: const Text("-Pilih Jenis Cuti-"),
                value: selectedJenisCuti,
                items: jenisCutiList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedJenisCuti = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis Cuit harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Cuti Pada Tanggal
              const Text('Cuti Pada Tanggal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _startDate == null
                          ? '-Pilih Tanggal-'
                          : _dateFormat.format(_startDate!),
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.blueAccent,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_startDate == null || _startDate!.isUtc) {
                        return 'Tanggal harus diisi';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Sampai Tanggal
              const Text('Sampai Tanggal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _endDate == null
                          ? '-Pilih Tanggal-'
                          : _dateFormat.format(_endDate!),
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.blueAccent,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_endDate == null || _endDate!.isUtc) {
                        return 'Tanggal harus diisi';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Jumlah Cuti
              const Text('Jumlah Cuti (Hari)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 8),
              TextField(
                enabled: false,
                // controller: _jumlahCuti,
                decoration: InputDecoration(
                  hintText: _jumlahHariCuti == 0
                      ? 'Jumlah Cuti Hari'
                      : '$_jumlahHariCuti Hari',
                  border: const OutlineInputBorder(),
                  // errorText: _errorJumlahCuti
                ),
              ),
              const SizedBox(height: 16),
              // Masuk Kerja Tanggal
              const Text('Masuk Kerja Tanggal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: _masukKerjaDate == null
                      ? '-Pilih Tanggal-'
                      : _dateFormat.format(_masukKerjaDate!),
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Keterangan Cuti",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                controller: _keterangancutiController,
                decoration: InputDecoration(
                  hintText: "Keterangan Cuti",
                  hintStyle: TextStyle(
                      color: returnDate != null ? Colors.black : Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorText: _errorKeteranganCuti,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Keterangan Cuti harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Lampiran Wajib:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              AttachmentCard(
                title: 'Photo Copy Buku Nikah/KK - Menikah(3. Hk)',
              ),
              const SizedBox(height: 10),
              AttachmentCard(
                title: 'Photo copy Buku Nikah/KK-ANAK KANDUNG MENIKAH',
              ),
              const SizedBox(height: 10),
              AttachmentCard(
                title:
                    'Surat Kematian/KK (Orang tua/Mertua/Istri/Suami/Menantu/Anak)',
              ),
              const SizedBox(height: 10),
              AttachmentCard(
                title: 'Surat Khitan Anak / Babtis',
              ),
              const SizedBox(height: 10),
              AttachmentCard(
                title:
                    'Surat Kelahiran Anak/Photo copy Buku Nikah - ISTRI MELAHIRKAN"',
              ),

              const SizedBox(height: 24),
              // SizedBox(
              //   // width: double.maxFinite,
              //   child: ElevatedButton(
              //     onPressed: _submitForm,
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blue[800], // Warna latar belakang tombol
              //       foregroundColor: Colors.white, // Warna teks atau ikon
              //       shadowColor: Colors.black, // Warna bayangan
              //       elevation: 5, // Tinggi bayangan
              //     ),
              //     child: const Text('Ajukan'),
              //   ),
              // ),
              OutlinedButton.icon(
                onPressed: _submitForm,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue[800],
                  shadowColor: const Color.fromARGB(55, 66, 164, 245),
                  elevation: 5,
                ),

                // shadowColor.Colors.blackm
                icon: const Icon(Icons.check_box),
                label: const Text("Ajukan",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                // child: const Text('Start Quiz'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Mengonversi semua teks menjadi huruf besar
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class AttachmentCard extends StatefulWidget {
  final String title;

  AttachmentCard({required this.title});

  @override
  _AttachmentCardState createState() => _AttachmentCardState();
}

class _AttachmentCardState extends State<AttachmentCard> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _images.add(File(pickedFile.path));
  //     });
  //   }
  // }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _viewImage(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(image: image),
      ),
    );
  }

  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) return; // Prevent multiple taps
    setState(() {
      _isPickingImage = true;
    });

    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _isPickingImage = false; // Re-enable the button
    });

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with dynamic height
          Container(
            constraints: const BoxConstraints(maxHeight: 40),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.black),
            onPressed: _pickImage,
          ),
          const SizedBox(height: 10),
          Row(
            children: _images.asMap().entries.map((entry) {
              int index = entry.key;
              File image = entry.value;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      child: GestureDetector(
                        onTap: () => _viewImage(image),
                        child: Image.file(
                          image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(
                                0.5), // Transparent black background
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final File image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Lihat Gambar',
          style: TextStyle(
            color: Colors.white, // Ubah warna teks menjadi biru
            fontSize: 20, // Ukuran teks
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Mengubah warna ikon back menjadi putih
          onPressed: () {
            // Aksi saat ikon back ditekan
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Image.file(image),
      ),
    );
  }
}
