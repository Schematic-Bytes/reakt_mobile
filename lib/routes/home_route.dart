import 'package:flutter/cupertino.dart';
import 'package:reakt/routes/settings_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  bool onTapSos = false;
  bool onTapMic = false;
  String state = "default";

  @override
  Widget build(BuildContext context) {
    var sosState = SizedBox(
      height: MediaQuery.sizeOf(context).width,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF000000)),
        child: Text(
          "Tap here to send Emergeny message",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 28, color: Colors.white),
        ),
        onPressed: () async {
          setState(() {
            state = "loading";
          });

          await Future.delayed(const Duration(seconds: 3));

          setState(() {
            state = "done";
          });

          await Future.delayed(const Duration(seconds: 1));

          setState(() {
            state = "default";
          });
        },
      ),
    );
    if (state == "loading") {
      sosState = SizedBox(
        height: MediaQuery.sizeOf(context).width,
        width: MediaQuery.sizeOf(context).width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFFD71921),
          ),
          child: const CupertinoActivityIndicator(
            color: Colors.black,
            radius: 20,
          ),
          onPressed: () {},
        ),
      );
    } else if (state == "done") {
      sosState = SizedBox(
        height: MediaQuery.sizeOf(context).width,
        width: MediaQuery.sizeOf(context).width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFFD71921)),
          child: Text(
            "Message sent successfully",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 28, color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              onTapSos = !onTapSos;
            });
          },
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "Reakt",
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.6,
                          child: Text(
                            "Your location : Vadanappally Thrissur vvvvvvvv",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1C1B1E),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsRoute(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                      ),
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  sosState,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              onTapMic = !onTapMic;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: onTapMic
                                ? const Color(0xFFD71921)
                                : const Color(0xFF1C1B1E),
                          ),
                          child: onTapMic
                              ? const Icon(
                                  Icons.stop_circle_outlined,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.mic_none_outlined,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 50),
              Text(
                "Tap and hold the button to send voice note along with your current location.",
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1C1B1E)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
