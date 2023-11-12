import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPhonePermission() async {
  PermissionStatus status = await Permission.phone.status;

//   if (status.isDenied) {
//     // You can request the permission if it's not granted
//     status = await Permission.phone.request();
//     if (status.isGranted) {
//       // Permission granted
//       print('Phone permission granted!');
//     } else {
//       // Permission denied
//       print('Phone permission denied');
//     }
//   } else {
//     // Permission is already granted
//     print('Phone permission already granted');
//   }
}
