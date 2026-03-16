import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  bool isLoading = false;
  bool isPasswordVisible = false;

  String _getFriendlyErrorMessage(dynamic error) {
    String errorString = error.toString();
    
    if (errorString.contains("Invalid login credentials")) {
      return "Email atau password salah";
    } else if (errorString.contains("Email not confirmed")) {
      return "Email belum diverifikasi. Cek inbox email kamu";
    } else if (errorString.contains("rate limit")) {
      return "Terlalu banyak percobaan. Silakan coba lagi nanti";
    } else if (errorString.contains("network")) {
      return "Tidak ada koneksi internet";
    } else if (errorString.contains("timeout")) {
      return "Koneksi timeout. Periksa internet kamu";
    } else if (errorString.contains("user not found")) {
      return "Akun tidak ditemukan";
    } else {
      return errorString.replaceFirst("Exception: ", "");
    }
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(_getFriendlyErrorMessage(e))),
            ],
          ),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF020617), const Color(0xFF0F172A)]
                : [primaryColor.withOpacity(0.1), const Color(0xFFF4F6FA)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 25,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 60,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Selamat Datang!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Silahkan login untuk booking lapangan",
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white60 : Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 30),

                          _buildModernTextField(
                            controller: emailController,
                            label: "Email",
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              }
                              if (!value.contains("@")) {
                                return "Email tidak valid";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          _buildModernTextField(
                            controller: passwordController,
                            label: "Password",
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              }
                              if (value.length < 6) {
                                return "Password minimal 6 karakter";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: isLoading ? null : login,
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Belum punya akun?",
                                style: TextStyle(
                                  color: isDark ? Colors.white60 : Colors.grey.shade600,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: primaryColor,
                                ),
                                child: const Text(
                                  "Daftar Sekarang",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool isPassword = false,
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
          obscureText: isPassword ? !isPasswordVisible : false,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
          decoration: InputDecoration(
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
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}