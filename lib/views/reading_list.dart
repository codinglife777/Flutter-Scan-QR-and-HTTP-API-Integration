// ignore_for_file: prefer_const_constructors

import 'package:avensys_srl/global.dart';
import 'package:avensys_srl/helpers/http_helper.dart';
import 'package:avensys_srl/views/read_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReadingListPage extends StatefulWidget {
  const ReadingListPage({Key? key}) : super(key: key);

  @override
  State<ReadingListPage> createState() => _ReadingListPageState();
}

typedef CustomCB = void Function(String);

class _ReadingListPageState extends State<ReadingListPage> {
  void showAlertDialog(BuildContext context, String id, CustomCB cb) {
    // set up the buttons
    Widget cancelButton = SizedBox(
        width: 100,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Cancel'),
          backgroundColor: Colors.blue,
        ));
    Widget continueButton = SizedBox(
        width: 100,
        child: FloatingActionButton.extended(
          onPressed: () {
            cb(id);
            Navigator.pop(context);
          },
          label: const Text('Continue'),
          backgroundColor: Colors.red,
        ));
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove A Report"),
      content: Text("Would you like to remove a report?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void removeReport(String id) {
    deleteReport(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reading List"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<dynamic>>(
            future: getReadingList(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                List<dynamic> items = snapshot.data!;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    Map<String, dynamic> item = items[i];
                    return Card(
                      elevation: 3,
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 6.h,
                          child: Row(
                            children: [
                              Text(item['sz_item']),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  showAlertDialog(
                                      context, item['id'], removeReport);
                                },
                                icon: Icon(Icons.delete),
                              ),
                              SizedBox(width: 2.w),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => ReadDetailPage(
                                                detailItem: DetailItem(
                                                  id: item['id'],
                                                  item: item['sz_item'],
                                                  version: item['sz_version'],
                                                  supplier: item['sz_supplier'],
                                                  week: item['sz_week'],
                                                  year: item['sz_year'],
                                                  error: item['sz_error'],
                                                  errorCode:
                                                      item['sz_error_code'],
                                                  number: item['sz_number'],
                                                  remarks: item['sz_remarks'],
                                                  photos: item['photos'],
                                                  createdAt: item['created_at'],
                                                  updatedAt: item['updated_at'],
                                                ),
                                              )));
                                },
                                icon: Icon(Icons.remove_red_eye),
                              ),
                              SizedBox(width: 2.w),
                            ],
                          )),
                    );
                  },
                );
              }

              return Center(child: CircularProgressIndicator());
            }));
  }
}
