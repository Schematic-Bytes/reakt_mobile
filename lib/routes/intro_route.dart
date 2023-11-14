// import 'package:reakt/widgets/permission.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reakt/routes/features_route.dart';

class IntroRoute extends StatelessWidget {
  const IntroRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset("assets/images/intro-img.png"),
              Text(
                "Welcome to Reakt",
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A0606),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Safety is just a ",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF0A0606),
                  ),
                  children: [
                    TextSpan(
                      text: "Tap",
                      style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                    const TextSpan(text: " away."),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Features()),
                  );
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
