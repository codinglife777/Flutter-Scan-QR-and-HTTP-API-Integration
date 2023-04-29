import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

const String serverAddress = 'https://www.avensys-srl.com/QR_report';

Future<List> getErrorList() async {
  http.Response response =
      await http.get(Uri.https("www.avensys-srl.com", "/error_list_json.php"));
  return json.decode(response.body);
}

Future<List> getReadingList() async {
  http.Response response =
      await http.get(Uri.parse("$serverAddress/fetch.php"));
  return json.decode(response.body);
}

Future<void> deleteReport(String id) async {
  final res = await http
      .post(Uri.parse("$serverAddress/delete.php"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode({'id': id}))
      .then((value) => value);
}

dynamic reportError(Map<String, dynamic> data) async {
  final response = await http
      .post(Uri.parse("$serverAddress/report.php"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode(data))
      .then((value) => value);
  return json.decode(response.body);
}

Future<void> uploadImage(String id, List<File> images) async {
  String uploadurl = "$serverAddress/image_upload.php";
  // try {
  int index = 0;
  for (var element in images) {
    List<int> imageBytes = element.readAsBytesSync();
    // print(imageBytes);
    String baseimage = base64Encode(imageBytes);
    // print(baseimage);
    //convert file image to Base64 encoding
    var response = await http.post(Uri.parse(uploadurl),
        body: {'image': baseimage, 'id': id, 'index': index.toString()});
    index++;
    if (response.statusCode == 200) {
      //var jsondata = json.decode(response.body); //decode json data
      print("Image Upload Reply");
      print(response.body);
    } else {
      print("Error during connection to server");
      //there is error during connecting to server,
      //status code might be 404 = url not found
    }
  }
  // } catch (e) {
  //   print("Error during converting to Base64");
  //   //there is error during converting file image to base64 encoding.
  // }
}
