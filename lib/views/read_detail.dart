// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_interpolation_to_compose_strings, must_be_immutable, unnecessary_string_escapes

import 'package:avensys_srl/global.dart';
import 'package:avensys_srl/helpers/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReadDetailPage extends StatefulWidget {
  DetailItem detailItem;
  ReadDetailPage({Key? key, required this.detailItem}) : super(key: key);

  @override
  State<ReadDetailPage> createState() => _ReadDetailPageState();
}

class _ReadDetailPageState extends State<ReadDetailPage> {
  @override
  Widget build(BuildContext context) {
    DetailItem _detailItem = widget.detailItem;

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
                TextSpanFiled(title: "ITEM", subTitle: _detailItem.item),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "VERSION", subTitle: _detailItem.version),
                SizedBox(height: 2.h),
                TextSpanFiled(
                    title: "SUPPLIER", subTitle: _detailItem.supplier),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "WEEK", subTitle: _detailItem.week),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "YEAR", subTitle: _detailItem.year),
                SizedBox(height: 2.h),
                TextSpanFiled(title: "NUMBER", subTitle: _detailItem.number!),
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
                  child: Text(_detailItem.error!),
                ),
                SizedBox(height: 2.h),
                Divider(thickness: 0.2.h, color: Colors.black),
                (_detailItem.photos!.isEmpty)
                    ? Container()
                    : Container(
                        height: 15.h,
                        child: GridView.builder(
                          itemCount: _detailItem.photos!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            String imgUrl =
                                "$serverAddress/${_detailItem.photos![index]}";
                            print(imgUrl);
                            return Image.network(imgUrl);
                          },
                        ),
                      ),
                Divider(thickness: 0.2.h, color: Colors.black),
                Text(
                  _detailItem.remarks!,
                  maxLines: 5,
                  style: TextStyle(),
                ),
                SizedBox(height: 2.h),
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
