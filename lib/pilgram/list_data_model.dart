import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListDatalModel {
  String? name;
  String? shortDesc;
  String? imagePath;
  String? about;
  bool isShow = false;
  int index = 0;

  ListDatalModel(
      {this.name,
      this.shortDesc,
      this.imagePath,
      this.about,
      this.isShow = false});

  ListDatalModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imagePath = json['imagePath'];
    about = json['about'];
    isShow = json['isShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    data['about'] = this.about;
    data['isShow'] = this.isShow;
    return data;
  }
}

class Model {
  static List<ListDatalModel> getRitualList(BuildContext context) {
    List<ListDatalModel> list = [];
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.ritual1,
        shortDesc: AppLocalizations.of(context)!.ritual1ShortDesc,
        imagePath: "images/1.png",
        about: AppLocalizations.of(context)!.ritual1Desc));
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.ritual2,
        shortDesc: AppLocalizations.of(context)!.ritual2ShortDesc,
        imagePath: "images/2.png",
        about: AppLocalizations.of(context)!.ritual2Desc));
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.ritual3,
        shortDesc: AppLocalizations.of(context)!.ritual3ShortDesc,
        imagePath: "images/3.png",
        about: AppLocalizations.of(context)!.ritual3Desc));
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.ritual4,
        shortDesc: AppLocalizations.of(context)!.ritual4ShortDesc,
        imagePath: "images/4.png",
        about: AppLocalizations.of(context)!.ritual4Desc));
    return list;
  }

  static List<ListDatalModel> getHealthHabitsList(BuildContext context) {
    List<ListDatalModel> list = [];
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.habit1,
        shortDesc: AppLocalizations.of(context)!.habit1,
        imagePath: "images/1.png",
        about: AppLocalizations.of(context)!.habit1Desc));
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.habit2,
        shortDesc: AppLocalizations.of(context)!.habit2,
        imagePath: "images/2.png",
        about: AppLocalizations.of(context)!.habit2Desc));
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.habit3,
        shortDesc: AppLocalizations.of(context)!.habit3,
        imagePath: "images/2.png",
        about: AppLocalizations.of(context)!.habit3Desc));
    list.add(ListDatalModel(
        name: AppLocalizations.of(context)!.habit4,
        shortDesc: AppLocalizations.of(context)!.habit4,
        imagePath: "images/2.png",
        about: AppLocalizations.of(context)!.habit4Desc));
    return list;
  }
}
