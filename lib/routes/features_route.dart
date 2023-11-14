import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Features extends StatefulWidget {
  const Features({super.key});

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  var featuresIndex = 0;
  Map features = {
    0: ["One-tap emergency reporting", "Real-time location sharing"],
    1: ["Auto accident detection", "Personalized themes"],
    2: ["Accessibility menu", "Audio sharing"],
  };

  @override
  Widget build(BuildContext context) {
    final authService = context.read<FirebaseAuth>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset("assets/images/features-img.png"),
              Text(
                "Reakt features",
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.sizeOf(context).width / 3,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFF1F1F1),
                      ),
                      child: Center(
                        child: Text(
                          features[featuresIndex][0],
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0A0606),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.sizeOf(context).width / 3,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFF1F1F1),
                      ),
                      child: Center(
                        child: Text(
                          features[featuresIndex][1],
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0A0606),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    featuresIndex++;
                    if (featuresIndex == 3) {
                      featuresIndex = 0;
                    }
                  });
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: featuresIndex == 0 ? const Color(0xFF06080A) : const Color(0xFFB9B9B9),
                    ),
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: featuresIndex == 1 ? const Color(0xFF06080A) : const Color(0xFFB9B9B9),
                    ),
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: featuresIndex == 2 ? const Color(0xFF06080A) : const Color(0xFFB9B9B9),
                    ),
                    width: 10,
                    height: 10,
                  )
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  const status = [Permission.location, Permission.phone];
                  if (await Permission.location.isDenied || await Permission.phone.isDenied) {
                    await status.request();
                  }
                  final user = await authService.signInAnonymously();
                  context.go("/");
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: const Color(0xFF06080A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Lets go !",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
