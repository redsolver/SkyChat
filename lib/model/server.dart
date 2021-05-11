// To parse this JSON data, do
//
//     final server = serverFromJson(jsonString);

import 'dart:convert';

Server serverFromJson(String str) => Server.fromJson(json.decode(str));

String serverToJson(Server data) => json.encode(data.toJson());

class Server {
  String id;

  Server({
    this.self,
    this.name,
    this.description,
    this.icon,
    this.owners,
    this.memberList,
    this.channels,
  });

  final String self;
  final String name;
  final String description;
  final String icon;
  final List<String> owners;
  final String memberList;
  final Map<String, String> channels;

  factory Server.fromJson(Map<String, dynamic> json) => Server(
        self: json["_self"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        owners: List<String>.from(json["owners"].map((x) => x)),
        memberList: json["memberList"],
        channels: (json["channels"] as Map).map(
            (key, value) => MapEntry(key, value /* Channel.fromJson(value) */)),
      );

  Map<String, dynamic> toJson() => {
        "_self": self,
        "name": name,
        "description": description,
        "icon": icon,
        "owners": List<dynamic>.from(owners.map((x) => x)),
        "memberList": memberList,
        "channels": channels,
      };
}
