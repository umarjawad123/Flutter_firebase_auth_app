import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool loading = false;
  bool _obscureText = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) {
    return;
  }

    setState(() {
      loading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),

            password: passwordController.text.trim(),
          );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),

        'email': emailController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully")),
      );

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Signup Failed")));
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
              const SizedBox(height: 60),

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
                  Icons.person_add_alt_1,

                  color: Colors.white,

                  size: 55,
                ),
              ).animate().fade(duration: 600.ms).scale(),

              const SizedBox(height: 35),

              Text(
                "Create Account",

                style: GoogleFonts.poppins(
                  fontSize: 32,

                  fontWeight: FontWeight.bold,

                  color: AppColors.primary,
                ),
              ).animate().fade(delay: 200.ms).slideY(begin: .4),

              const SizedBox(height: 10),

              Text(
                "Create your new account",

                style: GoogleFonts.inter(
                  fontSize: 16,

                  color: Colors.grey.shade600,
                ),
              ).animate().fade(delay: 300.ms),

              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your name";
                        }

                        if (value.trim().length < 2) {
                          return "Name must be at least 2 characters";
                        }

                        return null;
                      },

                      decoration: buildDecoration(
                        "Full Name",
                        Icons.person_outline,
                        null,
                      ),
                    ).animate().fade(delay: 400.ms).slideX(begin: -.2),

                    const SizedBox(height: 20),

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
                    ).animate().fade(delay: 500.ms).slideX(begin: .2),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: passwordController,

                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
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
                    ).animate().fade(delay: 600.ms).slideX(begin: -.2),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,

                height: 58,

                child: ElevatedButton(
                  onPressed: loading ? null : signup,

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
                          "Create Account",

                          style: GoogleFonts.poppins(
                            fontSize: 18,

                            fontWeight: FontWeight.w600,

                            color: Colors.white,
                          ),
                        ),
                ),
              ).animate().fade(delay: 700.ms).slideY(begin: .5),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Already have an account?",

                    style: GoogleFonts.inter(color: Colors.grey.shade700),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },

                    child: Text(
                      "Login",

                      style: GoogleFonts.poppins(
                        color: AppColors.accent,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ).animate().fade(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}
