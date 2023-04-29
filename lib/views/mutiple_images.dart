// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class MultipleImages extends StatefulWidget {
  const MultipleImages({Key? key}) : super(key: key);

  @override
  State<MultipleImages> createState() => _MultipleImagesState();
}

class _MultipleImagesState extends State<MultipleImages> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();

    // if (selectedImages != null && selectedImages.length < 10) {
    //   imageFileList!.addAll(selectedImages);
    // } /*else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text("Not More Than 10 Images are Selected")));
    // }*/
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }

    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});

    if (selectedImages.length == 10) {
      imageFileList!.addAll(selectedImages);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Not More Than 10 Images are Selected")));
    }
  }

  final controller = MultiImagePickerController(
    maxImages: 10,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
    withData: true,
    withReadStream: true,
    images: <ImageFile>[],
    // array of pre/default selected images
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Images'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MultiImagePickerView(
              controller: controller,
              showAddMoreButton: true,
              showInitialContainer: true,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 4,
              ),
            ),
            /*(imageFileList!.length == 10)
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      selectImages();
                    },
                    child: Text('Select Images'),
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                        File(imageFileList![index].path),
                        fit: BoxFit.cover,
                      );
                    }),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imageFileList!.removeAt(0);
                });
              },
              child: Text("Delete"),
            )*/
          ],
        ),
      ),
    );
  }
}