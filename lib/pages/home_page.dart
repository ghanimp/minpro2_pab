import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import 'form_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> bookingList = [];

  @override
  void initState() {
    super.initState();
    getBookings();
  }

  Future<void> getBookings() async {
    final response = await supabase
        .from('booking')
        .select()
        .order('id', ascending: false);

    setState(() {
      bookingList = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> addBooking(Map<String, dynamic> data) async {
    await supabase.from('booking').insert(data);
    getBookings();
  }

  Future<void> updateBooking(int id, Map<String, dynamic> data) async {
    await supabase.from('booking').update(data).eq('id', id);
    getBookings();
  }

  void deleteBooking(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Booking"),
        content: const Text("Yakin ingin menghapus booking ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              await supabase.from('booking').delete().eq('id', id);
              Navigator.pop(context);
              getBookings();
            },
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final cardColor = Theme.of(context).cardColor;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: const Text(
          "Futsal Arena",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () => MyApp.of(context)?.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF020617), const Color(0xFF0F172A)]
                    : [primaryColor, const Color(0xFF22A05E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  top: -30,
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(
                      Icons.sports_soccer,
                      size: 180,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: -40,
                  bottom: -40,
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(
                      Icons.sports_soccer,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Selamat Datang,",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text("👋", style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Admin Futsal",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.event_available,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${bookingList.length} Total",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar Booking",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: bookingList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_soccer,
                          size: 80,
                          color: isDark ? Colors.white24 : Colors.grey.shade300,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Belum ada booking",
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white54 : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Klik tombol + untuk menambah",
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white38 : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: bookingList.length,
                    itemBuilder: (context, index) {
                      final data = bookingList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isDark
                                        ? [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)]
                                        : [primaryColor.withOpacity(0.1), primaryColor.withOpacity(0.05)],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  Icons.sports_soccer,
                                  color: primaryColor,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data["nama"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? Colors.white : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        data["lapangan"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 14,
                                          color: isDark ? Colors.white54 : Colors.grey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          data["nohp"],
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: isDark ? Colors.white70 : Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? primaryColor.withOpacity(0.2)
                                                : primaryColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 12,
                                                color: primaryColor,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                data["jam"],
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: isDark ? Colors.blue.shade300 : Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FormPage(
                                              bookingData: data,
                                            ),
                                          ),
                                        );
                                        if (result != null) {
                                          updateBooking(data["id"], result);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: isDark ? Colors.red.shade300 : Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () => deleteBooking(data["id"]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormPage(),
            ),
          );
          if (result != null) addBooking(result);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}