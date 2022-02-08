import 'package:flutter/material.dart';

class DrawerModel {
  int? id;
  IconData? image;
  String? name;
  bool hasList;
  bool? isExpanded;
  List<DrawerModel>? list = <DrawerModel>[];

  DrawerModel(
      {this.id,
      this.image,
      this.name,
      this.hasList = false,
      this.list,
      this.isExpanded});
}
