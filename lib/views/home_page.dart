// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              textAlign: TextAlign.center,
              "Quality Data\nCollection",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/qr_scanner_page');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(90.w, 5.h),
              ),
              child: Text("New Reading"),
            ),
            SizedBox(height: 2.h),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/reading_list');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(90.w, 5.h),
              ),
              child: Text("Reading List"),
            ),
          ],
        ),
      ),
    );
  }
}
