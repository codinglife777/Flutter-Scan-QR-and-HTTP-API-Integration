import 'dart:convert';

class DetailItem {
  String id;
  String item;
  String version;
  String supplier;
  String week;
  String year;
  String? number;
  String? error;
  String? errorCode;
  String? remarks;
  List<dynamic>? photos;
  String? createdAt;
  String? updatedAt;

  DetailItem(
      {required this.id,
      required this.item,
      required this.version,
      required this.supplier,
      required this.week,
      required this.year,
      required this.number,
      required this.error,
      required this.errorCode,
      required this.remarks,
      required this.photos,
      required this.createdAt,
      required this.updatedAt});
}
