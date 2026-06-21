import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool loading = false;
  bool _obscureText = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),

        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Login Failed")));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  InputDecoration buildDecoration(
    String hint,
    IconData icon,
    IconData? suffixIcon,
  ) {
    return InputDecoration(
      hintText: hint,

      hintStyle: GoogleFonts.inter(),

      prefixIcon: Icon(icon, color: AppColors.primary),

      suffixIcon: suffixIcon != null
          ? IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(suffixIcon, color: AppColors.primary),
            )
          : null,

      filled: true,

      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(vertical: 20),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),

          child: Column(
            children: [
              const SizedBox(height: 70),

              Container(
                height: 110,

                width: 110,

                decoration: BoxDecoration(
                  color: AppColors.primary,

                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary,

                      blurRadius: 25,

                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.lock_outline,

                  color: Colors.white,

                  size: 55,
                ),
              ).animate().fade(duration: 600.ms).scale(),

              const SizedBox(height: 35),

              Text(
                "Welcome Back",

                style: GoogleFonts.poppins(
                  fontSize: 34,

                  fontWeight: FontWeight.bold,

                  color: AppColors.primary,
                ),
              ).animate().fade(delay: 200.ms).slideY(begin: .4),

              const SizedBox(height: 10),

              Text(
                "Sign in to continue",

                style: GoogleFonts.inter(
                  fontSize: 16,

                  color: Colors.grey.shade600,
                ),
              ).animate().fade(delay: 300.ms),

              const SizedBox(height: 45),

              Form(
                key: _formKey,
                child: Column(children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }

                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value.trim())) {
                    return "Please Enter a valid email";
                  }

                  return null;
                },

                decoration: buildDecoration(
                  "Email",
                  Icons.email_outlined,
                  null,
                ),
              ).animate().fade(delay: 400.ms).slideX(begin: -.2),

              const SizedBox(height: 20),

              TextFormField(
                controller: passwordController,

                obscureText: _obscureText,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required";
                  }

                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }

                  return null;
                },

                decoration: buildDecoration(
                  "Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ).animate().fade(delay: 500.ms).slideX(begin: .2),
                ],)),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,

                height: 58,

                child: ElevatedButton(
                  onPressed: loading ? null : login,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Login",

                          style: GoogleFonts.poppins(
                            fontSize: 18,

                            fontWeight: FontWeight.w600,

                            color: Colors.white,
                          ),
                        ),
                ),
              ).animate().fade(delay: 600.ms).slideY(begin: .5),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Don't have an account?",

                    style: GoogleFonts.inter(color: Colors.grey.shade700),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },

                    child: Text(
                      "Sign Up",

                      style: GoogleFonts.poppins(
                        color: AppColors.accent,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ).animate().fade(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }
}
