import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  bool isLoading = false;
  bool isPasswordVisible = false;

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 10),
              const Expanded(child: Text("Register berhasil, silakan login")),
            ],
          ),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(e.toString())),
            ],
          ),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF4F6FA),
      
      appBar: AppBar(
        title: const Text(
          "Registrasi Akun",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                    child: const Icon(
                      Icons.person_add_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Buat Akun Baru",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Daftar untuk booking lapangan",
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
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                        isPasswordVisible: isPasswordVisible,
                        onVisibilityChanged: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
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

                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark 
                              ? Colors.white.withOpacity(0.05)
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              passwordController.text.length >= 6
                                  ? Icons.check_circle
                                  : Icons.info_outline,
                              size: 16,
                              color: passwordController.text.length >= 6
                                  ? Colors.green
                                  : Colors.grey.shade500,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Password minimal 6 karakter",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark 
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

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
                          onPressed: isLoading ? null : register,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Daftar Sekarang",
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

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sudah punya akun?",
                            style: TextStyle(
                              color: isDark ? Colors.white60 : Colors.grey.shade600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              foregroundColor: primaryColor,
                            ),
                            child: const Text(
                              "Login",
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
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onVisibilityChanged,
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
                    onPressed: onVisibilityChanged,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}