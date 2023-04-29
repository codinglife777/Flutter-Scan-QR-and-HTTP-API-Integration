import 'dart:io';

import 'package:camera_gallery_image_picker/camera_gallery_image_picker.dart';
import 'package:flutter/material.dart';

class CameraGalleryImagePickerExample extends StatefulWidget {
  const CameraGalleryImagePickerExample({super.key});

  @override
  State<CameraGalleryImagePickerExample> createState() =>
      _CameraGalleryImagePickerState();
}

class _CameraGalleryImagePickerState
    extends State<CameraGalleryImagePickerExample> {
  File? _imageFile;
  List<File> _multipleImageFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null) ...[
              Image.file(
                _imageFile!,
                height: 200,
              ),
              const SizedBox(height: 20)
            ],
            if (_multipleImageFiles.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _multipleImageFiles
                      .map(
                        (File file) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            file,
                            height: 100,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20)
            ],
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.camera,
                );
                setState(() {});
              },
              child: const Text(
                'Capture Image from Camera',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.gallery,
                );
                setState(() {});
              },
              child: const Text(
                'Pick Image from Gallery',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _imageFile = await CameraGalleryImagePicker.pickImage(
                  context: context,
                  source: ImagePickerSource.both,
                );
                setState(() {});
              },
              child: const Text(
                'Pick Image from Both',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                _multipleImageFiles =
                    await CameraGalleryImagePicker.pickMultiImage();
                setState(() {});
              },
              child: const Text(
                'Pick Multiple Images',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// // ignore_for_file: prefer_const_constructors
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   var _image;
//
//   Future getImage(ImgSource source) async {
//     var image = await ImagePickerGC.pickImage(
//
//         // enableCloseButton: true,
//         // closeIcon: Icon(
//         //   Icons.close,
//         //   color: Colors.red,
//         //   size: 12,
//         // ),
//         context: context,
//         source: source,
//         barrierDismissible: true,
//         cameraIcon: Icon(
//           Icons.camera_alt,
//           color: Colors.red,
//         ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
//         cameraText: Text(
//           "From Camera",
//           style: TextStyle(color: Colors.red),
//         ),
//         galleryText: Text(
//           "From Gallery",
//           style: TextStyle(color: Colors.blue),
//         ));
//     setState(() {
//       _image = image;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("HELLO"),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: 300,
//                 child: ElevatedButton(
//                   onPressed: () => getImage(ImgSource.Gallery),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.blue,
//                   ),
//                   child: Text(
//                     "From Gallery".toUpperCase(),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 300,
//                 child: ElevatedButton(
//                   onPressed: () => getImage(ImgSource.Camera),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.deepPurple,
//                   ),
//                   child: Text(
//                     "From Camera".toUpperCase(),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 300,
//                 child: ElevatedButton(
//                   onPressed: () => getImage(ImgSource.Both),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.red,
//                   ),
//                   child: Text(
//                     "Both".toUpperCase(),
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               _image != null ? Image.file(File(_image.path)) : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }