// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_interpolation_to_compose_strings, must_be_immutable, unnecessary_string_escapes

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:avensys_srl/helpers/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:sizer/sizer.dart';

import '../global.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int of = 0;
  String name = "";
  Uint8List? image;

  String encodedImage = "";
  String books = "";
  final ImagePicker imagePicker = ImagePicker();

  bool isCamera = false;
  String valueError = "";
  final _txtRemarksController = TextEditingController();
  final picker = ImagePicker();

  String strItem = '';
  String strVersion = '';
  String strSupplier = '';
  String strWeek = '';
  String strYear = '';
  String strNumber = '';
  String strErrorCode = '00-1';
  late List<dynamic> strErrList = [];
  Map<String, String> strErrorMap = {};
  List<File> imageFiles = [];

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    print(res);

    List<String> strarray = res!.split('|');

    strItem = strarray[0];
    strVersion = strarray[1];
    strSupplier = strarray[2];
    strWeek = strarray[3].substring(0, 2);
    strYear = strarray[3].substring(2, 4);
    strNumber = strarray.length == 4 ? strarray[3].substring(4) : strarray[4];

    void _reportError(int overwrite) async {
      final Map<String, dynamic> data = {
        'item': strItem,
        'version': strVersion,
        'supplier': strSupplier,
        'week': strWeek,
        'year': strYear,
        'number': strNumber,
        'error_code': strErrorCode,
        'error': strErrorMap[strErrorCode],
        'remarks': _txtRemarksController.text,
        'overrite': overwrite
      };

      String strMsg = '';
      Map<String, dynamic> response =
          await reportError(data).then((value) => value);
      if (response['code'] == '200') {
        strMsg = 'Successfully reported!';
        String? id = response['msg'];
        await uploadImage(id!, imageFiles);
        Navigator.pop(context);
        //upload image
      } else if (response['code'] == '201') {
        strMsg = 'The report failed';
      } else if (response['code'] == '202') {
        //already existing
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Data already existing!!! How do you wnat to proceed?"),
            content: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          _reportError(1);
                          Navigator.pop(context);
                        },
                        label: const Text('Overwirte Data'),
                        backgroundColor: Colors.blue,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 300,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          _reportError(2);
                          Navigator.pop(context);
                        },
                        label: const Text('Add Data'),
                        backgroundColor: Colors.blue,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 300,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: const Text('Cancel'),
                        backgroundColor: Colors.blue,
                      )),
                ],
              ),
            ),
          ),
        );
        return;
      } else if (response['code'] == '203') {
        strMsg = 'Invalid request';
      } else {
        strMsg = 'Unexpected error';
      }
      Fluttertoast.showToast(
          msg: strMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Details"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ...strarray.map((e) => Text(e)).toList(),
            Text(
              "$res".split('|').toString(),
              // "$res".split('|') as String,
            ),*/
                TextSpanFiled(title: "ITEM", subTitle: strItem),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "VERSION", subTitle: strVersion),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "SUPPLIER", subTitle: strSupplier),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "WEEK", subTitle: strWeek),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "YEAR", subTitle: strYear),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "NUMBER", subTitle: strNumber),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.only(left: 2.h),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade300.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  height: 6.h,
                  child: FutureBuilder<List<dynamic>>(
                      future: getErrorList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButton<String>(
                              hint: Text("Select"),
                              value: strErrorCode,
                              alignment: Alignment.center,
                              focusColor: Colors.transparent,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              // dropdownColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              onChanged: (newValue) {
                                setState(() {
                                  strErrorCode = newValue!;
                                });
                              },
                              items: snapshot.data?.map((fc) {
                                String code = fc['code'];

                                strErrorMap[fc['code']] = fc['description'];

                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(fc['description']),
                                );
                              }).toList());
                        }

                        return Center(child: CircularProgressIndicator());
                      }),
                ),
                SizedBox(height: 2.h),
                Divider(thickness: 0.2.h, color: Colors.black),
                // SizedBox(height: .h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (imageFiles.length == 10) {
                          Get.snackbar(
                            "",
                            "",
                            animationDuration: Duration(seconds: 0),
                            titleText:
                                Text("Not More Than 10 Images Are Added"),
                            barBlur: 50,
                            backgroundGradient: LinearGradient(
                                colors: [Colors.teal, Colors.black]),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          XFile? img = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            File compressedImage =
                                await FlutterNativeImage.compressImage(
                                    img.path);
                            setState(() {
                              imageFiles.add(compressedImage);
                            });
                          }
                        }
                      },
                      icon: Icon(Icons.add_circle_outline_outlined),
                    ),
                    Text(
                      "Add Picture",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () async {
                        XFile? img =
                            await picker.pickImage(source: ImageSource.camera);
                        if (img != null) {
                          File compressedImage =
                              await FlutterNativeImage.compressImage(img.path);
                          setState(() {
                            imageFiles.add(compressedImage);
                          });
                        }
                      },
                      icon: Icon(Icons.camera_alt),
                    ),
                  ],
                ),
                (imageFiles.isEmpty)
                    ? Container()
                    : Container(
                        height: 15.h,
                        child: GridView.builder(
                          itemCount: imageFiles.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Image.file(imageFiles[index]),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    imageFiles.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.close),
                              )
                            ]);
                          },
                        ),
                      ),
                Divider(thickness: 0.2.h, color: Colors.black),
                TextFormField(
                  controller: _txtRemarksController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Remarks",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  onPressed: () async {
                    if (strErrorCode == '') {
                      Get.snackbar("", "",
                          animationDuration: Duration(seconds: 0),
                          titleText: Text("Not"),
                          barBlur: 50,
                          backgroundGradient: LinearGradient(
                            colors: [
                              Colors.teal,
                              Colors.black,
                            ],
                          ),
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      _reportError(0);
                    }
                    // Get.toNamed('/qr_scanner_page');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(90.w, 5.h),
                  ),
                  child: Text("Save Data"),
                ),
              ],
            ),
          ),
        ));
  }
}

class TextSpanFiled extends StatelessWidget {
  String title;
  String subTitle;
  TextSpanFiled({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "$title : ",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: subTitle,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
