// To parse this JSON data, do
//
//     final appData = appDataFromJson(jsonString);

import 'dart:convert';

List<AppData> appDataFromJson(String str) => List<AppData>.from(json.decode(str).map((x) => AppData.fromJson(x)));

String appDataToJson(List<AppData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppData {
  AppData({
    required this.title,
    required this.appLogo,
    required this.description,
    required this.link,
  });

  String title;
  String appLogo;
  String description;
  String link;

  factory AppData.fromJson(Map<String, dynamic> json) => AppData(
    title: json["title"],
    appLogo: json["app_logo"],
    description: json["description"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "app_logo": appLogo,
    "description": description,
    "link": link,
  };
}
