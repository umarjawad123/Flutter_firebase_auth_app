import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    return doc.data() as Map<String, dynamic>;
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,

      MaterialPageRoute(builder: (_) => const LoginScreen()),

      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        automaticallyImplyLeading: false,

        title: Text(
          "My Profile",

          style: GoogleFonts.poppins(
            color: AppColors.primary,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder(
        future: getUserData(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),

            child: Column(
              children: [
                const SizedBox(height: 30),

                Container(
                  height: 120,

                  width: 120,

                  decoration: BoxDecoration(
                    color: AppColors.primary,

                    borderRadius: BorderRadius.circular(35),

                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary,

                        blurRadius: 25,

                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child:  Center(
                    child: Text(
                      data["name"][0],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                    
                        fontSize: 50,
                    
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).animate().fade().scale(),

                const SizedBox(height: 25),

                Text(
                  "Welcome Back 👋",

                  style: GoogleFonts.inter(
                    fontSize: 18,

                    color: Colors.grey.shade700,
                  ),
                ).animate().fade(delay: 200.ms),

                const SizedBox(height: 10),

                Text(
                  data['name'],

                  style: GoogleFonts.poppins(
                    fontSize: 32,

                    fontWeight: FontWeight.bold,

                    color: AppColors.primary,
                  ),
                ).animate().fade(delay: 300.ms).slideY(begin: .3),

                const SizedBox(height: 40),

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(25),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),

                        blurRadius: 20,

                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),

                              borderRadius: BorderRadius.circular(15),
                            ),

                            child: const Icon(
                              Icons.person_outline,

                              color: AppColors.primary,
                            ),
                          ),

                          const SizedBox(width: 18),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Full Name",

                                style: GoogleFonts.inter(color: Colors.grey),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                data['name'],

                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,

                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.15),

                              borderRadius: BorderRadius.circular(15),
                            ),

                            child: const Icon(
                              Icons.email_outlined,

                              color: AppColors.primary,
                            ),
                          ),

                          const SizedBox(width: 18),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "Email",

                                  style: GoogleFonts.inter(color: Colors.grey),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  data['email'],

                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,

                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fade(delay: 400.ms).slideY(begin: .3),

                const SizedBox(height: 45),

                SizedBox(
                  width: double.infinity,

                  height: 58,

                  child: ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    child: Text(
                      "Logout",

                      style: GoogleFonts.poppins(
                        color: Colors.white,

                        fontSize: 18,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ).animate().fade(delay: 600.ms).slideY(begin: .5),
              ],
            ),
          );
        },
      ),
    );
  }
}
