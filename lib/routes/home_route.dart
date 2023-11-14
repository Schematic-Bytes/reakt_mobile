import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:provider/provider.dart';
import 'package:reakt/routes/settings_route.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  String state = "default";
  bool onTapMic = false;

  Future<Placemark> getCurrentLocationPlacemark(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    final locationData = placemarks.where((loc) => loc.thoroughfare?.isNotEmpty ?? false);
    return locationData.first;
  }

  @override
  Widget build(BuildContext context) {
    final database = context.read<FirebaseFirestore>();

    var sosState = SizedBox(
      height: MediaQuery.sizeOf(context).width,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: const Color(0xFF000000)),
        child: Text(
          "Tap here to send Emergency message",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 28, color: Colors.white),
        ),
        onPressed: () async {
          setState(() {
            state = "loading";
          });

          final loc = await Geolocator.getCurrentPosition();

          await Future.delayed(const Duration(seconds: 3));
          final landmark = await getCurrentLocationPlacemark(loc);

          final geohash = GeoPoint(loc.latitude, loc.longitude);

          final String? mobileNumber = await MobileNumber.mobileNumber;

          await database.collection("requests").add({
            "geohash": geohash,
            "location": {
              "sub": landmark.thoroughfare,
              "locality": landmark.locality,
              "postalcode": landmark.postalCode,
            },
            "phone": mobileNumber
          });

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
          style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: const Color(0xFFD71921)),
          child: Text(
            "Message sent successfully",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 28, color: Colors.white),
          ),
          onPressed: () {},
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
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          "Reakt",
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        FutureBuilder<Placemark>(
                            future: Geolocator.getCurrentPosition().then((value) => getCurrentLocationPlacemark(value)),
                            builder: (context, snapshot) {
                              String location = "loading";
                              if (snapshot.hasData) {
                                Placemark? data = snapshot.data;
                                location = "${data!.thoroughfare}";
                              }
                              return Text(
                                "Your location : $location",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1C1B1E),
                                ),
                              );
                            }),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50), color: const Color.fromRGBO(179, 179, 179, 0.1)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SettingsRoute()),
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
              ),
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1C1B1E)),
                          child: const Icon(
                            Icons.mic_none_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FutureBuilder<Placemark>(
                        future: Geolocator.getCurrentPosition().then((value) => getCurrentLocationPlacemark(value)),
                        builder: (context, snapshot) {
                          String location = "loading";
                          if (snapshot.hasData) {
                            Placemark? data = snapshot.data;
                            location = "${data!.thoroughfare}";
                          }
                          return Text(
                            "Your location : $location",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1C1B1E),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromRGBO(179, 179, 179, 0.1),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsRoute()),
                    );
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                  ),
                  iconSize: 30,
                ),
              ),
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1C1B1E)),
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
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Tap the red SOS button to send an emergency alert to the nearest police station.",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1C1B1E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
