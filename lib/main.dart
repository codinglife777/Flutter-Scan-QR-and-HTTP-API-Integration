// ignore_for_file: prefer_const_constructors

import 'package:avensys_srl/views/details_page.dart';
import 'package:avensys_srl/views/home_page.dart';
import 'package:avensys_srl/views/mutiple_images.dart';
import 'package:avensys_srl/views/picke_both_file.dart';
import 'package:avensys_srl/views/qr_scanner_page.dart';
import 'package:avensys_srl/views/reading_list.dart';
import 'package:avensys_srl/views/test_qr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'montserrat',
        ),
        // initialRoute: '/homePage',
        getPages: [
          GetPage(name: "/", page: () => HomePage()),
          GetPage(name: "/qr_scanner_page", page: () => QrScanner()),
          // GetPage(name: "/qr_scanner_page", page: () => MyHome()),
          GetPage(name: "/details_page", page: () => DetailPage()),
          GetPage(name: "/multiple_image_page", page: () => MultipleImages()),
          GetPage(name: "/reading_list", page: () => ReadingListPage()),
          GetPage(
              name: "/homePage", page: () => CameraGalleryImagePickerExample()),
        ],
      );
    });
  }
}
