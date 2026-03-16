import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic>? bookingData;

  const FormPage({super.key, this.bookingData});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final noHpController = TextEditingController();
  final jamController = TextEditingController();

  String? selectedLapangan;

  final List<String> lapanganList = [
    "Lapangan 1",
    "Lapangan 2",
    "Lapangan 3",
    "Lapangan 4",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.bookingData != null) {
      namaController.text = widget.bookingData!["nama"] ?? "";
      noHpController.text = widget.bookingData!["nohp"] ?? "";
      jamController.text = widget.bookingData!["jam"] ?? "";
      selectedLapangan = widget.bookingData!["lapangan"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF4F6FA),
      
      appBar: AppBar(
        title: Text(
          widget.bookingData == null ? "Tambah Booking" : "Edit Booking",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.bookingData == null
                          ? Icons.add_rounded
                          : Icons.edit_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.bookingData == null
                              ? "Booking Baru"
                              : "Edit Booking",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.bookingData == null
                              ? "Isi data dengan lengkap"
                              : "Ubah data booking",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildModernTextField(
                        controller: namaController,
                        label: "Nama Pemesan",
                        icon: Icons.person_outline_rounded,
                        hint: "Masukkan nama lengkap",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama tidak boleh kosong";
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return "Nama hanya boleh huruf";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _buildModernTextField(
                        controller: noHpController,
                        label: "Nomor HP",
                        icon: Icons.phone_android_rounded,
                        hint: "Contoh: 0812-3456-7890",
                        keyboardType: TextInputType.phone,
                        inputFormatters: [PhoneNumberFormatter()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nomor HP tidak boleh kosong";
                          }
                          String digits = value.replaceAll("-", "");
                          if (digits.length < 10) {
                            return "Minimal 10 digit";
                          }
                          if (digits.length > 13) {
                            return "Maksimal 13 digit";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _buildModernDropdown(),

                      const SizedBox(height: 20),

                      _buildModernJamField(),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context, {
                                "nama": namaController.text,
                                "nohp": noHpController.text,
                                "lapangan": selectedLapangan ?? "",
                                "jam": jamController.text,
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget.bookingData == null
                                    ? Icons.save_rounded
                                    : Icons.update_rounded,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                widget.bookingData == null
                                    ? "Simpan Booking"
                                    : "Update Booking",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required String? Function(String?) validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 6),
          child: Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? Colors.white38 : Colors.grey.shade400,
              fontSize: 14,
            ),
            filled: true,
            fillColor: isDark 
                ? const Color(0xFF0F172A).withOpacity(0.5)
                : Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade200,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernDropdown() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 6),
          child: Row(
            children: [
              Icon(Icons.sports_soccer_rounded, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                "Nomor Lapangan",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark 
                ? const Color(0xFF0F172A).withOpacity(0.5)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white12 : Colors.grey.shade200,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedLapangan,
            hint: const Text("Pilih lapangan"),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primaryColor,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            items: lapanganList.map((lapangan) {
              return DropdownMenuItem(
                value: lapangan,
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      lapangan,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedLapangan = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Pilih nomor lapangan";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModernJamField() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 6),
          child: Row(
            children: [
              Icon(Icons.access_time_rounded, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                "Jam Booking",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: jamController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.\-]')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Jam booking tidak boleh kosong";
            }
            return null;
          },
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: "Contoh: 13.20-15.00",
            hintStyle: TextStyle(
              color: isDark ? Colors.white38 : Colors.grey.shade400,
              fontSize: 14,
            ),
            filled: true,
            fillColor: isDark 
                ? const Color(0xFF0F172A).withOpacity(0.5)
                : Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade200,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 13) {
      digits = digits.substring(0, 13);
    }

    String formatted = "";
    for (int i = 0; i < digits.length; i++) {
      if (i == 4 || i == 8) {
        formatted += "-";
      }
      formatted += digits[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}